import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/models/course.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'widgets/course_filter_widget.dart';
import 'widgets/course_item_widget.dart';

class CoursesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: AppSizes.hugeTextSize);

    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.all(AppSizes.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(AppLocalizations.of(context).courses, style: titleStyle),
          SizedBox(
            height: AppSizes.verticalItemSpacing,
          ),
          Container(child: CourseFilterWidget()),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    ));
  }
}
