import 'package:flutter/material.dart';
import 'package:lettutor_app/models/course.dart';

import 'course_item_widget.dart';

class CourseList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<CourseTmp> courses = CourseTmp.courseList;
    return Column(
      children: [
        for (var element in courses) ...[
          CourseItemWidget(course: element),
          SizedBox(
            height: 15,
          )
        ]
      ],
    );
  }
}
