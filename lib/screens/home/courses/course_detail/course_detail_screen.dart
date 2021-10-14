import 'package:flutter/material.dart';
import 'package:lettutor_app/config/theme.dart';
import 'package:lettutor_app/models/course.dart';
import 'package:lettutor_app/widgets/app_bar.dart';

class CourseDetail extends StatelessWidget {
  final Course course;
  CourseDetail({@required this.course});

  @override
  Widget build(BuildContext context) {
    final courseNameTextStyle = TextStyle(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);
    final titleTextStyle = TextStyle(
      color: AppTheme.mainColor,
      fontSize: 15,
      fontWeight: FontWeight.bold,
    );
    final contentTextStyle = TextStyle(color: Colors.black, fontSize: 13);
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: ApplicationAppBar(
        title: 'Course detail',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset(
              course.image,
              fit: BoxFit.cover,
            ),
            Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      course.name,
                      style: courseNameTextStyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      course.shortDescription,
                      style: contentTextStyle,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Overview',
                      style: titleTextStyle,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        course.overview,
                        style: contentTextStyle,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Experience Level',
                      style: titleTextStyle,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        course.experienceLevel,
                        style: contentTextStyle,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Course length',
                      style: titleTextStyle,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        '${course.courseLength} topics',
                        style: contentTextStyle,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'List topics',
                      style: titleTextStyle,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    ...course.topics
                        .map((e) => Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                e,
                                style: contentTextStyle,
                              ),
                            ))
                        .toList()
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

_buildFlatButton({Widget icon, Function() function, String title}) {
  final ButtonStyle buttonStyle = TextButton.styleFrom(
      primary: AppTheme.mainColor, backgroundColor: Colors.transparent);
  return TextButton(
      onPressed: function,
      style: buttonStyle,
      child: Column(
        children: <Widget>[
          icon,
          SizedBox(
            height: 4,
          ),
          Text(title,
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14))
        ],
      ));
}
