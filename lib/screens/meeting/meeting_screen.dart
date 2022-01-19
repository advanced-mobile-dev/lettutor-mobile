import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/meeting/meeting_bloc.dart';
import 'package:lettutor_app/routes.dart';
import 'package:lettutor_app/utils/date_utils.dart';
import 'package:lettutor_app/utils/dialog_utils.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:lettutor_app/widgets/loading_overlay.dart';
import 'package:lettutor_app/widgets/outline_button.dart';
import 'package:lettutor_app/widgets/submit_button.dart';
import 'package:lettutor_app/widgets/time_remaining.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'widgets/detail_row.dart';

class MeetingScreen extends StatelessWidget {
  final LoadingOverlay _loadingOverlay = new LoadingOverlay();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ApplicationAppBar(
          title: '${AppLocalizations.of(context).meeting}',
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
                  SnackBar(
                      content: Text('${AppLocalizations.of(context).failed}')),
                );
            }
            if (state.removeStatus == MeetingRemoveStatus.success) {
              DialogUtils.showCustomDialog(context,
                  title: '${AppLocalizations.of(context).success}',
                  content: '${AppLocalizations.of(context).meetingCancelled}',
                  barrierDismissible: false,
                  dialogType: DialogType.success,
                  okBtnText: 'Ok', onOkPressed: () {
                Navigator.popUntil(context,
                    (route) => route.settings.name == LettutorRoutes.home);
              });
            }
          },
          builder: (context, state) {
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
                            title: '${AppLocalizations.of(context).remaining}',
                            content: TimeRemaining(
                                state.booking.scheduleDetail.startPeriod),
                          ),
                          DetailRow(
                              title: '${AppLocalizations.of(context).start}',
                              content: Text(
                                '${MyDateUtils.getTime(state.booking.scheduleDetail.startPeriod)}',
                              )),
                          DetailRow(
                            title: '${AppLocalizations.of(context).duration}',
                            content: Text(
                              '${MyDateUtils.getTimeDuration(state.booking.scheduleDetail.startPeriod, state.booking.scheduleDetail.endPeriod)} ${AppLocalizations.of(context).minutes}',
                            ),
                          ),
                          DetailRow(
                              title: '${AppLocalizations.of(context).tutor}',
                              content: Text(
                                '${state.booking.scheduleDetail.tutorBasicInfo.name}',
                              )),
                          state.booking.bookingInfo.studentRequest == null
                              ? SizedBox()
                              : DetailRow(
                                  title: '${AppLocalizations.of(context).note}',
                                  content: Text(
                                    '${state.booking.bookingInfo.studentRequest}',
                                  )),
                          _remainingMinutes > 120
                              ? Container(
                                  alignment: Alignment.bottomRight,
                                  child: CustomTextButton(
                                      text:
                                          '${AppLocalizations.of(context).cancel}',
                                      function: () {
                                        DialogUtils.showCustomDialog(
                                          context,
                                          content:
                                              '${AppLocalizations.of(context).cancelMeetingContent}',
                                          okBtnText:
                                              '${AppLocalizations.of(context).yes}',
                                          cancelBtnText:
                                              '${AppLocalizations.of(context).no}',
                                          onOkPressed: () {
                                            _cancelMeeting();
                                            Navigator.pop(context);
                                          },
                                          onCancelPressed: () {
                                            Navigator.pop(context);
                                          },
                                          title:
                                              '${AppLocalizations.of(context).cancelMeeting}',
                                        );
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
                        text: '${AppLocalizations.of(context).startMeeting}',
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
