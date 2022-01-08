import 'package:flutter/material.dart';
import 'package:lettutor_app/models/student_booking/student_booking.dart';
import 'package:lettutor_app/screens/video-conference.dart/widgets/jisti_meeting.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'widgets/count_down_video_conference.dart';

class VideoConferenceScreen extends StatelessWidget {
  final StudentBooking studentBooking;
  VideoConferenceScreen(this.studentBooking);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationAppBar(
        title: AppLocalizations.of(context).videoConference,
      ),
      body: Stack(
        children: [
          Meeting(studentBooking),
          Center(
            child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(5)),
                child: Center(child: CountDownVideoConference(studentBooking))),
          ),
        ],
      ),
    );
  }
}
