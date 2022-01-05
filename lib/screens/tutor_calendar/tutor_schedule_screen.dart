import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/tutor_schedule/tutor_schedule_bloc.dart';
import 'package:lettutor_app/config/routes.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';
import 'package:lettutor_app/models/tutor_schedule/schedule_detail.dart';
import 'package:lettutor_app/screens/booking/booking_screen.dart';
import 'package:lettutor_app/utils/date_utils.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TutorScheduleScreen extends StatelessWidget {
  final Tutor tutor;
  TutorScheduleScreen({this.tutor});
  @override
  Widget build(BuildContext context) {
    _buildTimeFrame(ScheduleDetail e) {
      String hour = MyDateUtils.getTimeFrame(e.startPeriod, e.endPeriod);
      return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(LettutorRoutes.booking,
                arguments: BookingScreenArguments(
                  tutor: tutor,
                  scheduleDetail: e,
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

    _buildDateCalendar(String dateString, List<ScheduleDetail> schedules) {
      String result = MyDateUtils.getScheduleDateString(dateString);
      DateTime convertDate = MyDateUtils.formatStringToDate(dateString);
      return Column(children: [
        convertDate.weekday == 1
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                alignment: Alignment.topLeft,
                child: Text(
                  '${MyDateUtils.getWeek(convertDate)}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))
            : SizedBox(),
        Padding(
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
                result,
                style: TextStyle(color: Colors.white),
              ),
              color: Color(0xff3269A5),
            ),
            expanded: Column(
              children: [...schedules.map((e) => _buildTimeFrame(e)).toList()],
            ),
            collapsed: null,
          ),
        ),
      ]);
    }

    return Scaffold(
        appBar: ApplicationAppBar(
          title: AppLocalizations.of(context).calendar,
        ),
        body: BlocConsumer<TutorScheduleBloc, TutorScheduleState>(
          builder: (context, state) {
            if (state is TutorBookingInitial)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (state is LoadFailureState) return Text('Load data failure!!!');

            if (state is SchedulesLoadedState) {
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: state.tutorSchedules.dateSchedules
                        .map((e) => _buildDateCalendar(e.date, e.schedules))
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
