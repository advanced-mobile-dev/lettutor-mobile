import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/config/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor_app/models/course/course.dart';
import 'package:lettutor_app/models/course/course_level.dart';

class CourseItemWidget extends StatelessWidget {
  final Course course;

  CourseItemWidget({this.course});
  @override
  Widget build(BuildContext context) {
    final courseLevel = CourseLevel.data
        .firstWhere((e) => e.level == int.parse(course.level), orElse: null);
    final courseLevelName = courseLevel != null ? courseLevel.name : '';
    return GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(LettutorRoutes.courseDetail, arguments: course);
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 3))
              ]),
          // padding: EdgeInsets.all(AppSizes.cardPadding),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Image.network(
                  course.imageUrl,
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(
                height: AppSizes.horizontalItemSpacing,
              ),
              Container(
                  alignment: Alignment.center,
                  child: Text(
                    course.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.smallTextSize),
                    textAlign: TextAlign.center,
                  )),
              SizedBox(
                height: AppSizes.horizontalItemSpacing,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.bottomRight,
                  child: Text(
                      '$courseLevelName - ${course.topics.length} ${AppLocalizations.of(context).topics}',
                      style: TextStyle(
                          fontSize: AppSizes.smallTextSize,
                          fontWeight: FontWeight.normal)),
                ),
              )
            ],
          ),
        ));
  }
}
