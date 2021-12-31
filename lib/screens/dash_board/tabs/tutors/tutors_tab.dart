import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:lettutor_app/blocs/tutors/tutors_bloc.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor_app/models/tutor/tutor_filter.dart';
import 'package:lettutor_app/screens/dash_board/tabs/tutors/widgets/tutor_filter_bottom_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/tutor_search_bar.dart';
import 'widgets/tutor_list_widget.dart';

class TutorsTab extends StatefulWidget {
  @override
  State<TutorsTab> createState() => _TutorsTabState();
}

class _TutorsTabState extends State<TutorsTab> {
  TutorsBloc _tutorsBloc;

  @override
  Widget build(BuildContext context) {
    _tutorsBloc = context.watch<TutorsBloc>();
    return Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context).tutors,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.hugeTextSize)),
                Badge(
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
                          _tutorsBloc
                              .add(ApplyFilterEvent(tutorFilter: filter));
                        }
                      },
                      icon: Icon(
                        Icons.filter_list_alt,
                        size: 36,
                      )),
                )
              ],
            ),
            SizedBox(
              height: AppSizes.verticalItemSpacing,
            ),
            TutorSearchBar(),
            SizedBox(
              height: 15,
            ),
            Expanded(child: TutorListWidget())
          ],
        ));
  }
}
