import 'package:lettutor_app/models/course/course.dart';
import 'package:lettutor_app/models/tutor/tutor_feedback.dart';

class TutorBasicInfo {
  String id;
  String level;
  String email;
  String google;
  String facebook;
  String apple;
  String avatar;
  String name;
  String country;
  String phone;
  String language;
  String birthday;
  bool requestPassword;
  bool isActivated;
  bool isPhoneActivated;
  String requireNote;
  int timezone;
  String phoneAuth;
  bool isPhoneAuthActivated;
  String createdAt;
  String updatedAt;
  String deletedAt;
  List<TutorFeedback> feedbacks;
  List<Course> courses;

  TutorBasicInfo(
      {this.id,
      this.level,
      this.email,
      this.google,
      this.facebook,
      this.apple,
      this.avatar,
      this.name,
      this.country,
      this.phone,
      this.language,
      this.birthday,
      this.requestPassword,
      this.isActivated,
      this.isPhoneActivated,
      this.requireNote,
      this.timezone,
      this.phoneAuth,
      this.isPhoneAuthActivated,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.feedbacks,
      this.courses});

  double calcAvgRating() {
    int total = 0;
    for (var item in feedbacks) {
      total += item.rating;
    }
    if (feedbacks != null && feedbacks.isEmpty) return 0;
    return ((total / feedbacks.length) ~/ 1).toDouble();
  }

  TutorBasicInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    level = json['level'];
    email = json['email'];
    google = json['google'];
    facebook = json['facebook'];
    apple = json['apple'];
    avatar = json['avatar'];
    name = json['name'];
    country = json['country'];
    phone = json['phone'];
    language = json['language'];
    birthday = json['birthday'];
    requestPassword = json['requestPassword'];
    isActivated = json['isActivated'];
    isPhoneActivated = json['isPhoneActivated'];
    requireNote = json['requireNote'];
    timezone = json['timezone'];
    phoneAuth = json['phoneAuth'];
    isPhoneAuthActivated = json['isPhoneAuthActivated'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    if (json['feedbacks'] != null) {
      feedbacks = <TutorFeedback>[];
      json['feedbacks'].forEach((v) {
        feedbacks.add(new TutorFeedback.fromJson(v));
      });
    }
    if (json['courses'] != null) {
      courses = <Course>[];
      json['courses'].forEach((v) {
        courses.add(new Course.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['level'] = this.level;
    data['email'] = this.email;
    data['google'] = this.google;
    data['facebook'] = this.facebook;
    data['apple'] = this.apple;
    data['avatar'] = this.avatar;
    data['name'] = this.name;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['language'] = this.language;
    data['birthday'] = this.birthday;
    data['requestPassword'] = this.requestPassword;
    data['isActivated'] = this.isActivated;
    data['isPhoneActivated'] = this.isPhoneActivated;
    data['requireNote'] = this.requireNote;
    data['timezone'] = this.timezone;
    data['phoneAuth'] = this.phoneAuth;
    data['isPhoneAuthActivated'] = this.isPhoneAuthActivated;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    if (this.feedbacks != null) {
      data['feedbacks'] = this.feedbacks.map((v) => v.toJson()).toList();
    }
    if (this.courses != null) {
      data['courses'] = this.courses.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
