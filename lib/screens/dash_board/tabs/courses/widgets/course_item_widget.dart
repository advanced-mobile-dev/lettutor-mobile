import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:lettutor_app/constants/assets.dart';
import 'package:lettutor_app/routes.dart';
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
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(LettutorRoutes.courseDetail, arguments: course);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: <Widget>[
              Column(
                children: [
                  Hero(
                    tag: 'course-image${course.id}',
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: CachedNetworkImage(
                          placeholder: (context, url) => Image.asset(
                            Assets.loadingImage,
                            width: width / 2,
                          ),
                          imageUrl: course.imageUrl,
                          width: width / 2,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  alignment: Alignment.center,
                  child: Text(
                    course.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  )),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '$courseLevelName - ${course.topics.length} ${AppLocalizations.of(context).topics}',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
