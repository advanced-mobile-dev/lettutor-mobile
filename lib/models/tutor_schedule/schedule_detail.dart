import 'booking_info.dart';

class ScheduleDetail {
  DateTime startPeriod;
  DateTime endPeriod;
  String id;
  String scheduleId;
  String createdAt;
  String updatedAt;
  List<BookingInfo> bookingInfo;
  bool isBooked;

  ScheduleDetail(
      {this.startPeriod,
      this.endPeriod,
      this.id,
      this.scheduleId,
      this.createdAt,
      this.updatedAt,
      this.bookingInfo,
      this.isBooked});

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startPeriodTimestamp'] = this.startPeriod;
    data['endPeriodTimestamp'] = this.endPeriod;
    data['id'] = this.id;
    data['scheduleId'] = this.scheduleId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.bookingInfo != null) {
      data['bookingInfo'] = this.bookingInfo.map((v) => v.toJson()).toList();
    }
    data['isBooked'] = this.isBooked;
    return data;
  }
}
