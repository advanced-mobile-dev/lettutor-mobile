import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/tutor_schedule/tutor_schedule_bloc.dart';
import 'package:lettutor_app/constants/colors.dart';
import 'package:lettutor_app/routes.dart';
import 'package:lettutor_app/models/schedule/schedule_detail.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';
import 'package:lettutor_app/screens/reservation/reservation_screen.dart';
import 'package:lettutor_app/utils/date_utils.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:lettutor_app/widgets/empty_widget.dart';
import 'package:lettutor_app/widgets/error_widget.dart';

class TutorScheduleScreen extends StatelessWidget {
  final Tutor tutor;
  TutorScheduleScreen({this.tutor});
  @override
  Widget build(BuildContext context) {
    _buildTimeFrame(ScheduleDetail e) {
      String hour = MyDateUtils.getTimeFrame(e.startPeriod, e.endPeriod);
      return GestureDetector(
          onTap: !e.isBooked
              ? () async {
                  await Navigator.of(context).pushNamed(LettutorRoutes.booking,
                      arguments: ReservationScreenArguments(
                        tutor: tutor,
                        scheduleDetail: e,
                      ));
                }
              : null,
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 45, right: 45),
            margin: EdgeInsets.only(bottom: 1, top: 1),
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  e.isBooked ? '$hour (Booked)' : '$hour',
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
        convertDate.weekday == 1 || MyDateUtils.isToday(convertDate)
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                alignment: Alignment.centerLeft,
                height: 40,
                child: Text(
                  '${MyDateUtils.getWeek(convertDate)}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: AppColors.customGrey),
                ))
            : SizedBox(),
        Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: ExpandablePanel(
            theme: const ExpandableThemeData(
              headerAlignment: ExpandablePanelHeaderAlignment.center,
              tapBodyToExpand: true,
              tapBodyToCollapse: true,
              hasIcon: false,
            ),
            header: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 25, right: 15),
                margin: EdgeInsets.symmetric(vertical: 1),
                height: 40,
                width: double.infinity,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        result,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 24,
                        color: Theme.of(context).textTheme.bodyText1.color,
                      )
                    ]),
                color: Theme.of(context).cardColor),
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
          title: 'Schedule',
          // title: AppLocalizations.of(context).calendar,
        ),
        body: BlocConsumer<TutorScheduleBloc, TutorScheduleState>(
          builder: (context, state) {
            if (state is TutorScheduleLoading)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (state is TutorScheduleLoadFailureState)
              return AppErrorWidget(
                retry: () {
                  context
                      .read<TutorScheduleBloc>()
                      .add(TutorScheduleFetchEvent());
                },
              );

            if (state is TutorScheduleLoadedState) {
              if (state.tutorSchedules.data.isEmpty) return EmptyWidget();
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
