class BookingInfo {
  int createdAtTimeStamp;
  int updatedAtTimeStamp;
  String id;
  String userId;
  String scheduleDetailId;
  String tutorMeetingLink;
  String studentMeetingLink;
  String studentRequest;
  String tutorReview;
  int scoreByTutor;
  String createdAt;
  String updatedAt;
  String recordUrl;
  bool isDeleted;

  BookingInfo(
      {this.createdAtTimeStamp,
      this.updatedAtTimeStamp,
      this.id,
      this.userId,
      this.scheduleDetailId,
      this.tutorMeetingLink,
      this.studentMeetingLink,
      this.studentRequest,
      this.tutorReview,
      this.scoreByTutor,
      this.createdAt,
      this.updatedAt,
      this.recordUrl,
      this.isDeleted});

  BookingInfo.fromJson(Map<String, dynamic> json) {
    createdAtTimeStamp = json['createdAtTimeStamp'];
    updatedAtTimeStamp = json['updatedAtTimeStamp'];
    id = json['id'];
    userId = json['userId'];
    scheduleDetailId = json['scheduleDetailId'];
    tutorMeetingLink = json['tutorMeetingLink'];
    studentMeetingLink = json['studentMeetingLink'];
    studentRequest = json['studentRequest'];
    tutorReview = json['tutorReview'];
    scoreByTutor = json['scoreByTutor'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    recordUrl = json['recordUrl'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAtTimeStamp'] = this.createdAtTimeStamp;
    data['updatedAtTimeStamp'] = this.updatedAtTimeStamp;
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['scheduleDetailId'] = this.scheduleDetailId;
    data['tutorMeetingLink'] = this.tutorMeetingLink;
    data['studentMeetingLink'] = this.studentMeetingLink;
    data['studentRequest'] = this.studentRequest;
    data['tutorReview'] = this.tutorReview;
    data['scoreByTutor'] = this.scoreByTutor;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['recordUrl'] = this.recordUrl;
    data['isDeleted'] = this.isDeleted;
    return data;
  }
}
