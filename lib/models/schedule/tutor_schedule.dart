import 'package:lettutor_app/models/schedule/schedule_detail.dart';

class TutorSchedule {
  String id;
  String tutorId;
  String startTime;
  String endTime;
  DateTime startDateTime;
  DateTime endDateTime;
  String createdAt;
  bool isBooked;
  List<ScheduleDetail> scheduleDetails;

  TutorSchedule({
    this.id,
    this.tutorId,
    this.startTime,
    this.endTime,
    this.startDateTime,
    this.endDateTime,
    this.createdAt,
    this.isBooked,
    this.scheduleDetails,
  });

  TutorSchedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tutorId = json['tutorId'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    startDateTime =
        DateTime.fromMillisecondsSinceEpoch(json['startTimestamp'], isUtc: true)
            .toLocal();
    endDateTime =
        DateTime.fromMillisecondsSinceEpoch(json['endTimestamp'], isUtc: true)
            .toLocal();
    createdAt = json['createdAt'];
    isBooked = json['isBooked'];
    if (json['scheduleDetails'] != null) {
      scheduleDetails = <ScheduleDetail>[];
      json['scheduleDetails'].forEach((v) {
        scheduleDetails.add(new ScheduleDetail.fromJson(v));
      });
    }
  }
}
