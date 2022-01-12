import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/tutor_booking/tutor_booking_bloc.dart';
import 'package:lettutor_app/config/app_sizes.dart';
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

class BookingScreen extends StatelessWidget {
  final LoadingOverlay _loadingOverlay = new LoadingOverlay();
  final TextEditingController _noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final titleTextStyle = TextStyle(
        fontSize: AppSizes.normalTextSize, fontWeight: FontWeight.bold);
    final contentTextStyle = TextStyle(
        // color: AppTheme.textColor,
        fontSize: AppSizes.normalTextSize);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: ApplicationAppBar(
          title: AppLocalizations.of(context).bookAClass,
          actions: [
            TextButton(
                onPressed: () {},
                child: Text(
                  'Buy lessons',
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ),
        body: BlocConsumer<TutorBookingBloc, TutorBookingState>(
          listener: (context, state) {
            if (state.bookingStatus == BookingStatus.loading) {
              _loadingOverlay.show(context);
            } else {
              _loadingOverlay.hide();
            }

            if (state.bookingStatus == BookingStatus.success) {
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
                            Text("Booking success")
                          ],
                        ),
                        content: Text(
                          "Check your mail's inbox to see detail order",
                          // textAlign: TextAlign.center,
                        ),
                        actions: [
                          TextButton(
                            child: Text('Return home'),
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
            if (state.bookingStatus == BookingStatus.failed) {
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
                            Text("Booking failed")
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
                  padding: EdgeInsets.all(AppSizes.pagePadding),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TutorImageWidget(
                            tutorBasicInfo: state.tutor.tutorBasicInfo,
                            height: 100,
                            showRating: true),
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
                            MyDateUtils.getBookingTime(state.scheduleDetail),
                            style: contentTextStyle,
                          ),
                        ),
                        SizedBox(
                          height: AppSizes.verticalItemSpacing,
                        ),
                        Text(AppLocalizations.of(context).balance,
                            style: titleTextStyle),
                        SizedBox(
                          height: AppSizes.verticalItemSpacing,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            '${state.userWallet.amount ~/ 100000} ${AppLocalizations.of(context).lessonsLeft}',
                            style: contentTextStyle,
                          ),
                        ),
                        SizedBox(
                          height: AppSizes.verticalItemSpacing,
                        ),
                        Text(AppLocalizations.of(context).price,
                            style: titleTextStyle),
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
                          height: AppSizes.verticalItemSpacing,
                        ),
                        Text('Note', style: titleTextStyle),
                        SizedBox(
                          height: AppSizes.verticalItemSpacing,
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
                          text: AppLocalizations.of(context).book.toUpperCase(),
                          function: state.userWallet.amount <= 0 ||
                                  state.bookingStatus == BookingStatus.success
                              ? null
                              : () {
                                  // Navigator.popUntil(context,
                                  //     ModalRoute.withName(LettutorRoutes.home));
                                  context
                                      .read<TutorBookingBloc>()
                                      .add(BookEvent(_noteController.text));
                                },
                        ),
                        SizedBox(
                          height: AppSizes.verticalItemSpacing,
                        ),
                        SubmitButton(
                          text:
                              AppLocalizations.of(context).cancel.toUpperCase(),
                          function: () {
                            if (state.bookingStatus == BookingStatus.success)
                              Navigator.popUntil(
                                  context,
                                  (route) =>
                                      route.settings.name ==
                                      LettutorRoutes.home);
                            else
                              Navigator.pop(context);
                          },
                          backgroundColor: Colors.white,
                          textColor: Theme.of(context).primaryColor,
                        ),
                      ])),
            );
          },
        ));
  }
}

class BookingScreenArguments {
  final Tutor tutor;
  final ScheduleDetail scheduleDetail;

  BookingScreenArguments({this.tutor, this.scheduleDetail});
}
