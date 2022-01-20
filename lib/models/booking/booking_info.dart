import 'package:lettutor_app/models/booking/meeting_room.dart';
import 'dart:convert';

class BookingInfo {
  int createdAtTimeStamp;
  int updatedAtTimeStamp;
  String id;
  String userId;
  String scheduleDetailId;
  MeetingRoom meetingRoom;
  String studentRequest;
  String tutorReview;
  int scoreByTutor;
  String recordUrl;

  BookingInfo(
      {this.createdAtTimeStamp,
      this.updatedAtTimeStamp,
      this.id,
      this.userId,
      this.scheduleDetailId,
      this.meetingRoom,
      this.studentRequest,
      this.tutorReview,
      this.scoreByTutor,
      this.recordUrl});

  BookingInfo.fromJson(Map<String, dynamic> json) {
    createdAtTimeStamp = json['createdAtTimeStamp'];
    updatedAtTimeStamp = json['updatedAtTimeStamp'];
    id = json['id'];
    userId = json['userId'];
    scheduleDetailId = json['scheduleDetailId'];
    if (json['studentMeetingLink'] != null) {
      final String res = (json['studentMeetingLink']);
      String token = res.replaceFirst('/call/?token=', '');
      String data = token.split('.')[1];
      // List<int> res = base64.decode(base64.normalize(data));
      String result = utf8.decode(base64Decode(base64.normalize(data)));
      meetingRoom = new MeetingRoom.fromJson(jsonDecode(result));
      meetingRoom.token = token;
    }
    studentRequest = json['studentRequest'];
    tutorReview = json['tutorReview'];
    scoreByTutor = json['scoreByTutor'];
    recordUrl = json['recordUrl'];
  }
}
