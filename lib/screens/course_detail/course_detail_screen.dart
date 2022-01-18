import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:lettutor_app/constants/assets.dart';
import 'package:lettutor_app/models/course/course.dart';
import 'package:lettutor_app/models/course/course_level.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'widgets/topic_item_widget.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;
  CourseDetailScreen({@required this.course});

  @override
  Widget build(BuildContext context) {
    final courseNameTextStyle = Theme.of(context).textTheme.headline5;
    final titleTextStyle =
        Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16);
    final contentTextStyle = Theme.of(context).textTheme.bodyText2;
    final courseLevel = CourseLevel.data
        .firstWhere((e) => e.level == int.parse(course.level), orElse: null);
    return Scaffold(
      appBar: ApplicationAppBar(
        title: AppLocalizations.of(context).courseDetail,
      ),
      body: Container(
        height: double.infinity,
        color: Theme.of(context).backgroundColor,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Hero(
                tag: 'course-image${course.id}',
                child: CachedNetworkImage(
                  placeholder: (context, url) =>
                      Image.asset(Assets.loadingImage),
                  imageUrl: course.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.centerLeft,
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
                        course.description,
                        style: contentTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Why take this course?',
                        style: titleTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${course.reason}',
                        style: contentTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'What will you be able to do',
                        style: titleTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        course.purpose,
                        style: contentTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        AppLocalizations.of(context).experienceLevel,
                        style: titleTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${courseLevel != null ? courseLevel.name : course.level}',
                        style: contentTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        AppLocalizations.of(context).courseLength,
                        style: titleTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${course.topics.length} ${AppLocalizations.of(context).topics}',
                        style: contentTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        AppLocalizations.of(context).listTopics,
                        style: titleTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ...course.topics.map((e) => TopicItemWidget(e)).toList(),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
