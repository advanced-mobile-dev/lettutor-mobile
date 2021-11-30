import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/models/course.dart';
import 'package:lettutor_app/screens/home/courses/course_list/course_filter_widget.dart';
import 'package:lettutor_app/screens/home/courses/course_list/course_item_widget.dart';

class CoursesTab extends StatelessWidget {
  final List<Course> courses = Course.courseList;
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
          Text('Courses', style: titleStyle),
          SizedBox(
            height: AppSizes.verticalItemSpacing,
          ),
          Container(child: CourseFilterWidget()),
          SizedBox(
            height: 15,
          ),
          for (var element in courses) ...[
            CourseItemWidget(course: element),
            SizedBox(
              height: 15,
            )
          ]
        ],
      ),
    ));
  }
}
