import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/config/theme.dart';
import 'package:lettutor_app/models/course.dart';
import 'package:lettutor_app/widgets/app_bar.dart';

class CourseDetail extends StatelessWidget {
  final Course course;
  CourseDetail({@required this.course});

  @override
  Widget build(BuildContext context) {
    final courseNameTextStyle = TextStyle(
        color: Colors.black,
        fontSize: AppSizes.largeTextSize,
        fontWeight: FontWeight.bold);
    final titleTextStyle = TextStyle(
      color: AppTheme.mainColor,
      fontSize: AppSizes.normalTextSize,
      fontWeight: FontWeight.bold,
    );
    final contentTextStyle =
        TextStyle(color: Colors.black, fontSize: AppSizes.normalTextSize);
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
                      course.shortDescription,
                      style: contentTextStyle,
                    ),
                    SizedBox(
                      height: AppSizes.verticalItemSpacing,
                    ),
                    Text(
                      'Overview',
                      style: titleTextStyle,
                    ),
                    SizedBox(
                      height: AppSizes.verticalItemSpacing,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.horizontalItemSpacing),
                      child: Text(
                        course.overview,
                        style: contentTextStyle,
                      ),
                    ),
                    SizedBox(
                      height: AppSizes.verticalItemSpacing,
                    ),
                    Text(
                      'Experience Level',
                      style: titleTextStyle,
                    ),
                    SizedBox(
                      height: AppSizes.verticalItemSpacing,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.horizontalItemSpacing),
                      child: Text(
                        course.experienceLevel,
                        style: contentTextStyle,
                      ),
                    ),
                    SizedBox(
                      height: AppSizes.verticalItemSpacing,
                    ),
                    Text(
                      'Course length',
                      style: titleTextStyle,
                    ),
                    SizedBox(
                      height: AppSizes.verticalItemSpacing,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.horizontalItemSpacing),
                      child: Text(
                        '${course.courseLength} topics',
                        style: contentTextStyle,
                      ),
                    ),
                    SizedBox(
                      height: AppSizes.verticalItemSpacing,
                    ),
                    Text(
                      'List topics',
                      style: titleTextStyle,
                    ),
                    SizedBox(
                      height: AppSizes.verticalItemSpacing,
                    ),
                    ...course.topics
                        .map((e) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppSizes.horizontalItemSpacing),
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
