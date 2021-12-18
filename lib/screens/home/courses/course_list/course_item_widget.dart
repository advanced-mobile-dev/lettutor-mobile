import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/config/routes.dart';
import 'package:lettutor_app/models/course.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CourseItemWidget extends StatelessWidget {
  final CourseTmp course;

  CourseItemWidget({this.course});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(LettutorRoutes.courseDetail, arguments: course);
      },
      child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 3))
              ]),
          padding: EdgeInsets.all(AppSizes.cardPadding),
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(course.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizes.normalTextSize))),
                SizedBox(
                  height: AppSizes.horizontalItemSpacing,
                ),
                Container(
                  height: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Container(
                              alignment: Alignment.topLeft,
                              child: Image.asset(course.image))),
                      Expanded(
                          flex: 1,
                          child: Text(course.shortDescription,
                              style: TextStyle(
                                  // color: AppTheme.textColor,
                                  color: Colors.black,
                                  fontSize: AppSizes.smallTextSize))),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                      '${course.experienceLevel} - ${course.courseLength} ${AppLocalizations.of(context).topics}',
                      style: TextStyle(
                          fontSize: AppSizes.smallTextSize,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                )
              ],
            ),
          )),
    );
  }
}
