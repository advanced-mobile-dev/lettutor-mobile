import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/student_booking/student_booking_bloc.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/models/student_booking/student_booking.dart';
import 'package:lettutor_app/widgets/student_schedule_widget.dart';
import 'upcomming_class_widget.dart';

class BookingListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentBookingBloc, StudentBookingState>(
      builder: (context, state) {
        if (state is ListLoadingState)
          return Center(
            child: CircularProgressIndicator(),
          );
        if (state is ListLoadFailureState) {
          return Center(
            child: Text('Failed'),
          );
        }
        if (state is ListLoadedState) {
          if (state.bookingList.length == 0)
            return Center(
              child: Text('Empty'),
            );
          StudentBooking upcommingClass = state.bookingList[0];
          return Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(0),
            child: Column(
              children: <Widget>[
                UpcommingClassWidget(upcommingClass),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                  ),
                  height: 45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Others',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizes.normalTextSize),
                      ),
                    ],
                  ),
                ),
                Column(
                    children: state.bookingList
                        .where((element) =>
                            element.bookingInfo.id !=
                            upcommingClass.bookingInfo.id)
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: StudentBookingWidget(
                              studentSchedule: e,
                            ),
                          ),
                        )
                        .toList()),
                (state.status == SBListStatus.loadingMore)
                    ? CircularProgressIndicator()
                    : SizedBox()
              ],
            ),
          );
        }

        return SizedBox();
      },
    );
  }
}
