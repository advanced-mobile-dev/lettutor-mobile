import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor_app/config/theme.dart';
import 'package:lettutor_app/models/course.dart';

class CourseItemWidget extends StatelessWidget {
  final Course course;

  CourseItemWidget({this.course});
  @override
  Widget build(BuildContext context) {
    return Container(
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
        padding: EdgeInsets.all(15),
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                  // padding: EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.centerLeft,
                  child: Text(course.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15))),
              SizedBox(
                height: 10,
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
                                color: AppTheme.textColor, fontSize: 10))),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: Text(
                    '${course.experienceLevel} - ${course.courseLength} topics',
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ));
  }
}
