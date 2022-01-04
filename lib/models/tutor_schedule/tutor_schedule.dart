import 'schedule_detail.dart';

class TutorSchedule {
  String id;
  String tutorId;
  String startTime;
  String endTime;
  int startTimestamp;
  int endTimestamp;
  String createdAt;
  bool isBooked;
  List<ScheduleDetail> scheduleDetails;

  TutorSchedule(
      {this.id,
      this.tutorId,
      this.startTime,
      this.endTime,
      this.startTimestamp,
      this.endTimestamp,
      this.createdAt,
      this.isBooked,
      this.scheduleDetails});

  TutorSchedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tutorId = json['tutorId'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    startTimestamp = json['startTimestamp'];
    endTimestamp = json['endTimestamp'];
    createdAt = json['createdAt'];
    isBooked = json['isBooked'];
    if (json['scheduleDetails'] != null) {
      scheduleDetails = <ScheduleDetail>[];
      json['scheduleDetails'].forEach((v) {
        scheduleDetails.add(new ScheduleDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tutorId'] = this.tutorId;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['startTimestamp'] = this.startTimestamp;
    data['endTimestamp'] = this.endTimestamp;
    data['createdAt'] = this.createdAt;
    data['isBooked'] = this.isBooked;
    if (this.scheduleDetails != null) {
      data['scheduleDetails'] =
          this.scheduleDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
