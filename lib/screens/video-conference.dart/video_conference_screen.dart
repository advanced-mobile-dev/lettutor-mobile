import 'package:flutter/material.dart';
import 'package:lettutor_app/models/booking/booking.dart';
import 'package:lettutor_app/screens/video-conference.dart/widgets/jisti_meeting.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VideoConferenceScreen extends StatelessWidget {
  final Booking studentBooking;
  VideoConferenceScreen(this.studentBooking);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationAppBar(
        title: AppLocalizations.of(context).videoConference,
      ),
      body: Meeting(studentBooking),
    );
  }
}
