import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/meeting/meeting_bloc.dart';
import 'package:lettutor_app/blocs/student_booking/student_booking_bloc.dart';
import 'package:lettutor_app/routes.dart';
import 'package:lettutor_app/utils/date_utils.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:lettutor_app/widgets/loading_overlay.dart';
import 'package:lettutor_app/widgets/outline_button.dart';
import 'package:lettutor_app/widgets/submit_button.dart';
import 'package:lettutor_app/widgets/time_remaining.dart';

import 'widgets/detail_row.dart';

class MeetingScreen extends StatelessWidget {
  final LoadingOverlay _loadingOverlay = new LoadingOverlay();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ApplicationAppBar(
          title: 'Meeting',
        ),
        body: BlocConsumer<MeetingBloc, MeetingState>(
          listener: (context, state) {
            if (state.removeStatus == MeetingRemoveStatus.loading) {
              _loadingOverlay.show(context);
            } else {
              _loadingOverlay.hide();
            }
            if (state.removeStatus == MeetingRemoveStatus.failure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text('Failed')),
                );
            }
            if (state.removeStatus == MeetingRemoveStatus.success) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                        title: Row(
                          children: [
                            Icon(
                              Icons.check_box_rounded,
                              size: 36,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text("Sucess")
                          ],
                        ),
                        content: Text(
                          "Your meeting has been cancelled!!!",
                          // textAlign: TextAlign.center,
                        ),
                        actions: [
                          TextButton(
                            child: Text('Ok'),
                            onPressed: () {
                              Navigator.popUntil(
                                  context,
                                  (route) =>
                                      route.settings.name ==
                                      LettutorRoutes.home);
                            },
                          ),
                        ],
                      ));
            }
          },
          builder: (context, state) {
            print('build');
            void _cancelMeeting() {
              context.read<MeetingBloc>().add(CancelMeetingEvent());
            }

            int _remainingMinutes = state.booking.scheduleDetail.startPeriod
                .difference(DateTime.now())
                .inMinutes;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          DetailRow(
                            title: 'Remaining',
                            content: TimeRemaining(
                                state.booking.scheduleDetail.startPeriod),
                          ),
                          DetailRow(
                              title: 'Start',
                              content: Text(
                                '${MyDateUtils.getTime(state.booking.scheduleDetail.startPeriod)}',
                              )),
                          DetailRow(
                            title: 'Duration',
                            content: Text(
                              '${MyDateUtils.getTimeDuration(state.booking.scheduleDetail.startPeriod, state.booking.scheduleDetail.endPeriod)}',
                            ),
                          ),
                          DetailRow(
                              title: 'Tutor',
                              content: Text(
                                '${state.booking.scheduleDetail.tutorBasicInfo.name}',
                              )),
                          state.booking.bookingInfo.studentRequest == null
                              ? SizedBox()
                              : DetailRow(
                                  title: 'Note',
                                  content: Text(
                                    '${state.booking.bookingInfo.studentRequest}',
                                  )),
                          _remainingMinutes > 120
                              ? Container(
                                  alignment: Alignment.bottomRight,
                                  child: CustomTextButton(
                                      text: 'Cancel',
                                      function: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: Text("Cancel meeting"),
                                                  content: Text(
                                                    "Do you want to cancel this meeting?",
                                                    // textAlign: TextAlign.center,
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      child: Text('No'),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: Text('Yes'),
                                                      onPressed: () {
                                                        _cancelMeeting();
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ],
                                                ));
                                      },
                                      iconData: Icons.delete,
                                      color: Colors.red),
                                )
                              : SizedBox()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    SubmitButton(
                        text: 'Start meeting',
                        function: _remainingMinutes <= 120
                            ? () async {
                                context
                                    .read<MeetingBloc>()
                                    .add(StartMeetingEvent());
                              }
                            : null),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
