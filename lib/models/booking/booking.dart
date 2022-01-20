import 'package:lettutor_app/models/booking/booking_info.dart';
import 'package:lettutor_app/models/schedule/schedule_detail.dart';

class Booking {
  BookingInfo bookingInfo;
  ScheduleDetail scheduleDetail;

  Booking({this.bookingInfo, this.scheduleDetail});

  Booking.fromJson(Map<String, dynamic> json) {
    bookingInfo = BookingInfo.fromJson(json);
    scheduleDetail = ScheduleDetail.fromJson(json['scheduleDetailInfo']);
  }
}
