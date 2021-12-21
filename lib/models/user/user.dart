import 'package:lettutor_app/models/course/course.dart';
import 'package:lettutor_app/models/user/user-learn-topic.dart';
import 'package:lettutor_app/models/user/user-token.dart';
import 'package:lettutor_app/models/user/user-wallet.dart';

class User {
  String id;
  String email;
  String name;
  String avatar;
  String country;
  String phone;
  List<String> roles;
  String language;
  String birthday;
  bool isActivated;
  UserWallet walletInfo;
  List<Course> courses;
  String requireNote;
  String level;
  List<UserLearnTopic> learnTopics;
  List<String> testPreparations;
  bool isPhoneActivated;
  int timezone;
  UserToken userToken;

  User(
      {this.id,
      this.email,
      this.name,
      this.avatar,
      this.country,
      this.phone,
      this.roles,
      this.language,
      this.birthday,
      this.isActivated,
      this.walletInfo,
      this.courses,
      this.requireNote,
      this.level,
      this.learnTopics,
      this.testPreparations,
      this.isPhoneActivated,
      this.timezone,
      this.userToken});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    avatar = json['avatar'];
    country = json['country'];
    phone = json['phone'];
    roles = json['roles'].cast<String>();
    language = json['language'];
    birthday = json['birthday'];
    isActivated = json['isActivated'];
    walletInfo = json['walletInfo'] != null
        ? new UserWallet.fromJson(json['walletInfo'])
        : null;
    if (json['courses'] != null) {
      courses = <Course>[];
      json['courses'].forEach((v) {
        courses.add(new Course.fromJson(v));
      });
    }
    requireNote = json['requireNote'];
    level = json['level'];
    if (json['learnTopics'] != null) {
      learnTopics = <UserLearnTopic>[];
      json['learnTopics'].forEach((v) {
        learnTopics.add(new UserLearnTopic.fromJson(v));
      });
    }
    testPreparations = json['testPreparations'].cast<String>();
    isPhoneActivated = json['isPhoneActivated'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['roles'] = this.roles;
    data['language'] = this.language;
    data['birthday'] = this.birthday;
    data['isActivated'] = this.isActivated;
    if (this.walletInfo != null) {
      data['walletInfo'] = this.walletInfo.toJson();
    }
    if (this.courses != null) {
      data['courses'] = this.courses.map((v) => v.toJson()).toList();
    }
    data['requireNote'] = this.requireNote;
    data['level'] = this.level;
    if (this.learnTopics != null) {
      data['learnTopics'] = this.learnTopics.map((v) => v.toJson()).toList();
    }
    data['testPreparations'] = this.testPreparations;
    data['isPhoneActivated'] = this.isPhoneActivated;
    data['timezone'] = this.timezone;
    return data;
  }
}
