import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/config/routes.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';
import 'package:lettutor_app/models/tutor_schedule/schedule_detail.dart';
import 'package:lettutor_app/models/upcomming_lesson.dart';
import 'package:lettutor_app/screens/tutor_profile/widgets/tutor_header.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:lettutor_app/widgets/submit_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookingScreen extends StatelessWidget {
  final Tutor tutor;
  final ScheduleDetail scheduleDetail;
  BookingScreen({@required this.tutor, @required this.scheduleDetail});

  @override
  Widget build(BuildContext context) {
    print(tutor);
    final titleTextStyle = TextStyle(
        fontSize: AppSizes.normalTextSize, fontWeight: FontWeight.bold);
    final contentTextStyle = TextStyle(
        // color: AppTheme.textColor,
        fontSize: AppSizes.normalTextSize);
    return Scaffold(
      appBar: ApplicationAppBar(
        title: AppLocalizations.of(context).bookAClass,
      ),
      body: Container(
          padding: EdgeInsets.all(AppSizes.pagePadding),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
            TutorHeader(tutor),
            SizedBox(
              height: AppSizes.verticalItemSpacing,
            ),
            Text(
              AppLocalizations.of(context).bookingTime,
              style: titleTextStyle,
            ),
            SizedBox(
              height: AppSizes.verticalItemSpacing,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                '15:00 - 17:00, Monday 07/12/2021',
                style: contentTextStyle,
              ),
            ),
            SizedBox(
              height: AppSizes.verticalItemSpacing,
            ),
            Text(AppLocalizations.of(context).balance, style: titleTextStyle),
            SizedBox(
              height: AppSizes.verticalItemSpacing,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                '17 ${AppLocalizations.of(context).lessonsLeft}',
                style: contentTextStyle,
              ),
            ),
            SizedBox(
              height: AppSizes.verticalItemSpacing,
            ),
            Text(AppLocalizations.of(context).price, style: titleTextStyle),
            SizedBox(
              height: AppSizes.verticalItemSpacing,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                '1 ${AppLocalizations.of(context).lesson}',
                style: contentTextStyle,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SubmitButton(
              text: AppLocalizations.of(context).book.toUpperCase(),
              function: () {
                UpcommingLessonTmp.sampleData.add(
                    UpcommingLessonTmp(3, tutor, '21/12/2021', '15:00 17:00'));
                Navigator.popUntil(
                    context, ModalRoute.withName(LettutorRoutes.home));
              },
            ),
            SizedBox(
              height: AppSizes.verticalItemSpacing,
            ),
            SubmitButton(
              text: AppLocalizations.of(context).cancel.toUpperCase(),
              function: () {
                Navigator.pop(context);
              },
              backgroundColor: Colors.white,
              textColor: Theme.of(context).primaryColor,
            ),
          ])),
    );
  }
}

class BookingScreenArguments {
  final Tutor tutor;
  final ScheduleDetail scheduleDetail;

  BookingScreenArguments({this.tutor, this.scheduleDetail});
}
