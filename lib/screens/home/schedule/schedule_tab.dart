import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/config/routes.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/models/upcomming_lesson.dart';
import 'package:lettutor_app/widgets/upcomming_lesson_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScheduleTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: AppSizes.pagePadding),
              child: Column(
                children: <Widget>[
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset('assets/icons/logo.svg',
                          color: Theme.of(context).primaryColor),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(LettutorRoutes.history);
                        },
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.history,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                AppLocalizations.of(context).history,
                                style: TextStyle(
                                  fontSize: AppSizes.normalTextSize,
                                ),
                              )
                            ]),
                      ),
                    ],
                  )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Row(children: [
                        Icon(
                          Icons.timer,
                          size: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${AppLocalizations.of(context).totalLearnedTime}: 36 ${AppLocalizations.of(context).hours} 12 ${AppLocalizations.of(context).minutes}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizes.normalTextSize,
                          ),
                        ),
                      ])),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSizes.pagePadding),
              child: Column(
                children: <Widget>[
                  ...UpcommingLesson.sampleData
                      .map((e) => Column(
                            children: [
                              UpcommingLessonWidget(upcommingLesson: e),
                              SizedBox(
                                height: AppSizes.verticalItemSpacing * 2,
                              )
                            ],
                          ))
                      .toList()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
