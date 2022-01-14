import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/courses/courses_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor_app/models/filter/course_filter.dart';

import 'filter_bottom_sheet.dart';

class TabHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _coursesBloc = context.watch<CoursesBloc>();
    return BlocBuilder<CoursesBloc, CoursesState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppLocalizations.of(context).courses,
                style: Theme.of(context).textTheme.headline4),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Badge(
                // showBadge: _tutorsBloc.tutorFilter.specialities.isNotEmpty,
                badgeColor: Theme.of(context).primaryColor,
                showBadge: _coursesBloc.courseFilter.filterNumber() != '',
                badgeContent: Text(
                  '${_coursesBloc.courseFilter.filterNumber()}',
                  style: TextStyle(color: Colors.white),
                ),
                child: IconButton(
                    onPressed: () async {
                      final CourseFilter filter = await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) =>
                            CourseFilterBottomSheet(_coursesBloc.courseFilter),
                      );
                      if (filter != null) {
                        context
                            .read<CoursesBloc>()
                            .add(ApplyCourseFilterEvent(courseFilter: filter));
                      }
                    },
                    icon: Icon(
                      Icons.filter_list_outlined,
                      size: 36,
                      // color: Theme.of(context).primaryColor,
                    )),
              ),
            ),
          ],
        );
      },
    );
  }
}
