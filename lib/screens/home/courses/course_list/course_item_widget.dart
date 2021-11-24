import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/config/theme.dart';
import 'package:lettutor_app/models/course.dart';
import 'package:lettutor_app/screens/home/courses/course_detail/course_detail_screen.dart';

class CourseItemWidget extends StatelessWidget {
  final Course course;

  CourseItemWidget({this.course});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CourseDetailScreen(
                  course: course,
                )));
      },
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.8),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 3))
              ]),
          padding: EdgeInsets.all(AppSizes.cardPadding),
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(course.name,
                        style: TextStyle(
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
                                  color: AppTheme.textColor,
                                  fontSize: AppSizes.smallTextSize))),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                      '${course.experienceLevel} - ${course.courseLength} topics',
                      style: TextStyle(
                          fontSize: AppSizes.smallTextSize,
                          fontWeight: FontWeight.bold)),
                )
              ],
            ),
          )),
    );
  }
}
