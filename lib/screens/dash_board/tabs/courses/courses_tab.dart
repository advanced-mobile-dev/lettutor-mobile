import 'package:flutter/material.dart';
import 'package:lettutor_app/screens/dash_board/tabs/courses/widgets/course_list_widget.dart';
import 'widgets/search_bar.dart';
import 'widgets/tab_header.dart';

class CoursesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Theme.of(context).backgroundColor,
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
          child: Column(
            children: [
              TabHeader(),
              SearchBar(),
            ],
          ),
        ),
        Expanded(child: CourseListWidget()),
      ],
    ));
  }
}
