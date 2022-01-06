import 'package:lettutor_app/models/schedule/booking_info.dart';
import 'package:lettutor_app/models/schedule/schedule_detail.dart';

class StudentBooking {
  BookingInfo bookingInfo;
  ScheduleDetail scheduleDetail;

  StudentBooking({this.bookingInfo, this.scheduleDetail});

  StudentBooking.fromJson(Map<String, dynamic> json) {
    bookingInfo = BookingInfo.fromJson(json);
    scheduleDetail = ScheduleDetail.fromJson(json['scheduleDetailInfo']);
  }
}
