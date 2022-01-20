import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/reservation/reservation_bloc.dart';

import 'package:lettutor_app/constants/colors.dart';
import 'package:lettutor_app/routes.dart';
import 'package:lettutor_app/models/schedule/schedule_detail.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';
import 'package:lettutor_app/utils/date_utils.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:lettutor_app/widgets/custom_text_field.dart';
import 'package:lettutor_app/widgets/loading_overlay.dart';
import 'package:lettutor_app/widgets/submit_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor_app/widgets/tutor_image.dart';

class ReservationScreen extends StatelessWidget {
  final LoadingOverlay _loadingOverlay = new LoadingOverlay();
  final TextEditingController _noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        resizeToAvoidBottomInset: true,
        appBar: ApplicationAppBar(
          title: AppLocalizations.of(context).bookAClass,
          actions: [
            TextButton(
                onPressed: () {},
                child: Text(
                  'Buy lessons',
                  style: Theme.of(context).textTheme.bodyText2,
                ))
          ],
        ),
        body: BlocConsumer<ReservationBloc, ReservationState>(
          listener: (context, state) {
            if (state.reservationStatus == ReservationStatus.loading) {
              _loadingOverlay.show(context);
            } else {
              _loadingOverlay.hide();
            }

            if (state.reservationStatus == ReservationStatus.success) {
              showDialog(
                  context: context,
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
                            Text(
                              "Success",
                              style: Theme.of(context).textTheme.bodyText2,
                            )
                          ],
                        ),
                        content: Text(
                          "Check your mail's inbox to see detail order",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        actions: [
                          TextButton(
                            child: Text(
                              'Return home',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
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
            if (state.reservationStatus == ReservationStatus.failed) {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Row(
                          children: [
                            Icon(
                              Icons.cancel,
                              size: 36,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text("Reservation failed")
                          ],
                        ),
                        content: Text("${state.errorMessage}"),
                        actions: [
                          TextButton(
                            child: Text('Go back'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TutorImageWidget(
                            tutorBasicInfo: state.tutor.tutorBasicInfo,
                            height: 100,
                            showRating: true),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          AppLocalizations.of(context).bookAClass,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            MyDateUtils.getBookingTime(state.scheduleDetail),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(AppLocalizations.of(context).balance,
                            style: Theme.of(context).textTheme.bodyText1),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            '${state.userWallet != null ? (state.userWallet.amount) ~/ 100000 : 0} ${AppLocalizations.of(context).lessonsLeft}',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(AppLocalizations.of(context).price,
                            style: Theme.of(context).textTheme.bodyText1),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            '1 ${AppLocalizations.of(context).lesson}',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Note',
                            style: Theme.of(context).textTheme.bodyText1),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          controller: _noteController,
                          maxLines: 3,
                          iconData: null,
                          title: '',
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        SubmitButton(
                          text: 'Book',
                          function: state.userWallet == null ||
                                  state.userWallet.amount <= 0 ||
                                  state.reservationStatus ==
                                      ReservationStatus.success
                              ? null
                              : () {
                                  // Navigator.popUntil(context,
                                  //     ModalRoute.withName(LettutorRoutes.home));
                                  context
                                      .read<ReservationBloc>()
                                      .add(BookEvent(_noteController.text));
                                },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SubmitButton(
                          text: AppLocalizations.of(context).cancel,
                          function: () {
                            if (state.reservationStatus ==
                                ReservationStatus.success)
                              Navigator.popUntil(
                                  context,
                                  (route) =>
                                      route.settings.name ==
                                      LettutorRoutes.home);
                            else
                              Navigator.pop(context);
                          },
                          backgroundColor: AppColors.customGrey,
                        ),
                      ])),
            );
          },
        ));
  }
}

class ReservationScreenArguments {
  final Tutor tutor;
  final ScheduleDetail scheduleDetail;

  ReservationScreenArguments({this.tutor, this.scheduleDetail});
}
