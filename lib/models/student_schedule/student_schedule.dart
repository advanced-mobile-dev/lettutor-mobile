import 'package:lettutor_app/models/schedule/booking_info.dart';
import 'package:lettutor_app/models/schedule/schedule_detail.dart';

class StudentSchedule {
  BookingInfo bookingInfo;
  ScheduleDetail scheduleDetail;

  StudentSchedule({this.bookingInfo, this.scheduleDetail});

  StudentSchedule.fromJson(Map<String, dynamic> json) {
    bookingInfo = BookingInfo.fromJson(json);
    scheduleDetail = ScheduleDetail.fromJson(json['scheduleDetailInfo']);
  }
}
