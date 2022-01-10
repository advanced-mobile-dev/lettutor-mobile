import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/models/course/course.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'widgets/topic_item_widget.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;
  CourseDetailScreen({@required this.course});

  @override
  Widget build(BuildContext context) {
    final courseNameTextStyle = TextStyle(
        fontSize: AppSizes.largeTextSize, fontWeight: FontWeight.bold);
    final titleTextStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: AppSizes.normalTextSize,
      fontWeight: FontWeight.bold,
    );
    final contentTextStyle = TextStyle(fontSize: AppSizes.normalTextSize);
    return Scaffold(
      appBar: ApplicationAppBar(
        title: AppLocalizations.of(context).courseDetail,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.network(
              course.imageUrl,
              fit: BoxFit.cover,
            ),
            Container(
                padding: EdgeInsets.all(AppSizes.pagePadding),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      course.name,
                      style: courseNameTextStyle,
                    ),
                    SizedBox(
                      height: AppSizes.verticalItemSpacing,
                    ),
                    Text(
                      course.description,
                      style: contentTextStyle,
                    ),
                    SizedBox(
                      height: AppSizes.verticalItemSpacing,
                    ),
                    Text(
                      'Why take this course?',
                      style: titleTextStyle,
                    ),
                    SizedBox(
                      height: AppSizes.verticalItemSpacing,
                    ),
                    Text(
                      '${course.reason}',
                      style: contentTextStyle,
                    ),
                    SizedBox(
                      height: AppSizes.verticalItemSpacing,
                    ),
                    Text(
                      'What will you be able to do',
                      style: titleTextStyle,
                    ),
                    SizedBox(
                      height: AppSizes.verticalItemSpacing,
                    ),
                    Text(
                      course.purpose,
                      style: contentTextStyle,
                    ),
                    SizedBox(
                      height: AppSizes.verticalItemSpacing,
                    ),
                    Text(
                      AppLocalizations.of(context).experienceLevel,
                      style: titleTextStyle,
                    ),
                    SizedBox(
                      height: AppSizes.verticalItemSpacing,
                    ),
                    Text(
                      course.level,
                      style: contentTextStyle,
                    ),
                    SizedBox(
                      height: AppSizes.verticalItemSpacing,
                    ),
                    Text(
                      AppLocalizations.of(context).courseLength,
                      style: titleTextStyle,
                    ),
                    SizedBox(
                      height: AppSizes.verticalItemSpacing,
                    ),
                    Text(
                      '${course.topics.length} ${AppLocalizations.of(context).topics}',
                      style: contentTextStyle,
                    ),
                    SizedBox(
                      height: AppSizes.verticalItemSpacing,
                    ),
                    Text(
                      AppLocalizations.of(context).listTopics,
                      style: titleTextStyle,
                    ),
                    SizedBox(
                      height: AppSizes.verticalItemSpacing,
                    ),
                    ...course.topics.map((e) => TopicItemWidget(e)).toList(),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
