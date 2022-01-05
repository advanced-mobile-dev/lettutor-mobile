import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/student_schedule/student_schedule_bloc.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/models/student_schedule/student_schedule.dart';
import 'package:lettutor_app/widgets/student_schedule_widget.dart';
import 'upcomming_class_widget.dart';

class ScheduleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentScheduleBloc, StudentScheduleState>(
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
          if (state.scheduleList.length == 0)
            return Center(
              child: Text('Empty'),
            );
          StudentSchedule upcommingClass = state.scheduleList[0];
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
                    children: state.scheduleList
                        .where((element) =>
                            element.bookingInfo.id !=
                            upcommingClass.bookingInfo.id)
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: StudentScheduleWidget(
                              studentSchedule: e,
                            ),
                          ),
                        )
                        .toList()),
                (state.status == SSListStatus.loadingMore)
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
