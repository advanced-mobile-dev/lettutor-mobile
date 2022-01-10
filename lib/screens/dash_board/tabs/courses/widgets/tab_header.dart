import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/courses/courses_bloc.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor_app/models/filter/course_filter.dart';

import 'filter_bottom_sheet.dart';

class TabHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _tutorBloc = context.watch<CoursesBloc>();
    return BlocBuilder<CoursesBloc, CoursesState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppLocalizations.of(context).courses,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.hugeTextSize)),
            Padding(
              padding: const EdgeInsets.only(top: 3, right: 10),
              child: Badge(
                // showBadge: _tutorsBloc.tutorFilter.specialities.isNotEmpty,
                showBadge: _tutorBloc.courseFilter.filterNumber() != '',
                badgeContent: Text(
                  '${_tutorBloc.courseFilter.filterNumber()}',
                  style: TextStyle(color: Colors.white),
                ),
                child: IconButton(
                    onPressed: () async {
                      final CourseFilter filter = await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) =>
                            CourseFilterBottomSheet(_tutorBloc.courseFilter),
                      );
                      if (filter != null) {
                        context
                            .read<CoursesBloc>()
                            .add(ApplyCoursesFilterEvent(courseFilter: filter));
                      }
                    },
                    icon: Icon(
                      Icons.filter_list_alt,
                      size: 36,
                      color: Theme.of(context).primaryColor,
                    )),
              ),
            )
          ],
        );
        return SizedBox();
      },
    );
  }
}
