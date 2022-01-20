import 'package:lettutor_app/models/tutor/tutor_basic_info.dart';
import '../booking/booking_info.dart';

class ScheduleDetail {
  DateTime startPeriod;
  DateTime endPeriod;
  String id;
  String scheduleId;
  String createdAt;
  String updatedAt;
  List<BookingInfo> bookingInfo;
  bool isBooked;
  TutorBasicInfo tutorBasicInfo;

  ScheduleDetail(
      {this.startPeriod,
      this.endPeriod,
      this.id,
      this.scheduleId,
      this.createdAt,
      this.updatedAt,
      this.bookingInfo,
      this.isBooked,
      this.tutorBasicInfo});

  ScheduleDetail.fromJson(Map<String, dynamic> json) {
    startPeriod = DateTime.fromMillisecondsSinceEpoch(
            json['startPeriodTimestamp'],
            isUtc: true)
        .toLocal();
    endPeriod = DateTime.fromMillisecondsSinceEpoch(json['endPeriodTimestamp'],
            isUtc: true)
        .toLocal();
    id = json['id'];
    scheduleId = json['scheduleId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['bookingInfo'] != null) {
      bookingInfo = <BookingInfo>[];
      json['bookingInfo'].forEach((v) {
        bookingInfo.add(new BookingInfo.fromJson(v));
      });
    }
    isBooked = json['isBooked'];

    if (json['scheduleInfo'] != null &&
        json['scheduleInfo']['tutorInfo'] != null) {
      tutorBasicInfo =
          TutorBasicInfo.fromJson(json['scheduleInfo']['tutorInfo']);
    }
  }
}
