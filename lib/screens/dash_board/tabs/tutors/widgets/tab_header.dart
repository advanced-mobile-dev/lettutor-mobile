import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/tutors/tutors_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor_app/models/filter/tutor_filter.dart';

import 'tutor_filter_bottom_sheet.dart';

class TutorsTabHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _tutorsBloc = context.watch<TutorsBloc>();
    return BlocBuilder<TutorsBloc, TutorsState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppLocalizations.of(context).tutors,
                style: Theme.of(context).textTheme.headline4),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Badge(
                badgeColor: Theme.of(context).primaryColor,
                showBadge: _tutorsBloc.tutorFilter.specialities.isNotEmpty,
                badgeContent: Text(
                  '1',
                  style: TextStyle(color: Colors.white),
                ),
                child: IconButton(
                    onPressed: () async {
                      final TutorFilter filter = await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) =>
                            TutorFilterBottomSheet(_tutorsBloc.tutorFilter),
                      );
                      if (filter != null) {
                        _tutorsBloc.add(ApplyTutorFilterEvent(
                            tutorFilter: _tutorsBloc.tutorFilter
                                .copyWith(specialities: filter.specialities)));
                      }
                    },
                    icon: Icon(
                      Icons.filter_list_outlined,
                      size: 36,
                    )),
              ),
            )
          ],
        );
      },
    );
  }
}
