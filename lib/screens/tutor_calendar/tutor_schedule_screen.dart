import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/tutor_booking/tutor_booking_bloc.dart';
import 'package:lettutor_app/config/routes.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';
import 'package:lettutor_app/models/tutor_schedule/schedule_detail.dart';
import 'package:lettutor_app/models/tutor_schedule/tutor_schedule.dart';
import 'package:lettutor_app/screens/booking/booking_screen.dart';
import 'package:lettutor_app/utils/date_utils.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TutorScheduleScreen extends StatelessWidget {
  final Tutor tutor;
  TutorScheduleScreen({this.tutor});
  @override
  Widget build(BuildContext context) {
    _buildTimeFrame(DateTime start, DateTime end) {
      String hour = MyDateUtils.getTimeFrame(start, end);
      return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(LettutorRoutes.booking,
                arguments: BookingScreenArguments(
                  tutor: tutor,
                  time: '15:00 - 17:00, Monday 11/10/2021',
                ));
          },
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 45, right: 45),
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1, color: Colors.grey))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  hour,
                ),
                Icon(Icons.keyboard_arrow_right)
              ],
            ),
          ));
    }

    _buildDateCalendar(String date, List<ScheduleDetail> schedules) {
      String dateString = MyDateUtils.getScheduleDateString(date);
      return Padding(
        padding: const EdgeInsets.only(bottom: 1),
        child: ExpandablePanel(
          theme: const ExpandableThemeData(
            headerAlignment: ExpandablePanelHeaderAlignment.center,
            tapBodyToExpand: true,
            tapBodyToCollapse: true,
            hasIcon: false,
          ),
          header: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 25),
            height: 40,
            width: double.infinity,
            child: Text(
              dateString,
              style: TextStyle(color: Colors.white),
            ),
            color: Color(0xff3269A5),
          ),
          expanded: Column(
            children: [
              ...schedules
                  .map((e) => _buildTimeFrame(e.startPeriod, e.endPeriod))
                  .toList()
              // _buildTimeFrame('15:00 - 17:00'),
              // _buildTimeFrame('17:00 - 19:00'),
              // _buildTimeFrame('19:00 - 21:00'),
              // _buildTimeFrame('21:00 - 23:00'),
            ],
          ),
          collapsed: null,
        ),
      );
    }

    // ;SingleChildScrollView(
    //       child: Container(
    //         child: Column(
    //           children: <Widget>[
    //             _buildDateCalendar('Monday, 11/10/2021'),
    //             _buildDateCalendar('Tuesday, 12/10/2021'),
    //             _buildDateCalendar('Thursday, 14/10/2021'),
    //             _buildDateCalendar('Friday, 15/10/2021'),
    //             _buildDateCalendar('Sunday, 16/10/2021'),
    //           ],
    //         ),
    //       ),
    //     ),
    return Scaffold(
        appBar: ApplicationAppBar(
          title: AppLocalizations.of(context).calendar,
        ),
        body: BlocConsumer<TutorBookingBloc, TutorBookingState>(
          builder: (context, state) {
            if (state is TutorBookingInitial)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (state is LoadFailureState) return Text('Failed!!!');

            if (state is SchedulesLoadedState) {
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: state.tutorSchedules.scheduleDetailMap.entries
                        .map((e) => _buildDateCalendar(e.key, e.value))
                        .toList(),
                  ),
                ),
              );
            }
            return SizedBox();
          },
          listener: (context, state) {},
        ));
  }
}
