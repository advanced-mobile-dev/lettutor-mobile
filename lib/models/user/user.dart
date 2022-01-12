import 'package:equatable/equatable.dart';
import 'package:lettutor_app/models/course/course.dart';
import 'package:lettutor_app/models/user/user_learn_topic.dart';
import 'package:lettutor_app/models/user/user_token.dart';
import 'package:lettutor_app/models/user/user_wallet.dart';

class User extends Equatable {
  String id;
  String email;
  String name;
  String avatar;
  String country;
  String phone;
  String language;
  String birthday;
  bool isActivated;
  List<Course> courses;
  String level;
  List<UserLearnTopic> learnTopics;
  List<String> testPreparations;
  bool isPhoneActivated;
  int timezone;
  UserWallet userWallet;
  UserToken userToken;

  User(
      {this.id,
      this.email,
      this.name,
      this.avatar,
      this.country,
      this.phone,
      this.language,
      this.birthday,
      this.isActivated,
      this.courses,
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
    language = json['language'];
    birthday = json['birthday'];
    isActivated = json['isActivated'];
    if (json['courses'] != null) {
      courses = <Course>[];
      json['courses'].forEach((v) {
        courses.add(new Course.fromJson(v));
      });
    }
    level = json['level'];
    if (json['learnTopics'] != null) {
      learnTopics = <UserLearnTopic>[];
      json['learnTopics'].forEach((v) {
        learnTopics.add(new UserLearnTopic.fromJson(v));
      });
    }
    if (json['testPreparations'] != null)
      testPreparations = json['testPreparations'].cast<String>();
    isPhoneActivated = json['isPhoneActivated'];
    timezone = json['timezone'];
    if (json['walletInfo'] != null)
      userWallet = UserWallet.fromJson(json['walletInfo']);
  }

  Map<String, dynamic> toJsonForPut() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['birthday'] = this.birthday;
    data['level'] = this.level;
    // if (this.learnTopics != null) {
    //   data['learnTopics'] = this.learnTopics.map((v) => v.toJson()).toList();
    // }
    // data['testPreparations'] = this.testPreparations;
    return data;
  }

  copyWith(
      {String name,
      String phone,
      String birthday,
      String country,
      String level,
      List<UserLearnTopic> learnTopics,
      List<String> testPreparations}) {
    return User(
        level: level ?? this.level,
        learnTopics: learnTopics ?? this.learnTopics,
        testPreparations: testPreparations ?? this.testPreparations,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        birthday: birthday ?? this.birthday,
        country: country ?? this.country,
        id: this.id,
        email: this.email,
        avatar: this.avatar,
        language: this.language,
        isActivated: this.isActivated,
        courses: this.courses,
        isPhoneActivated: this.isPhoneActivated,
        timezone: this.timezone,
        userToken: this.userToken);
  }

  @override
  List<Object> get props => [id, email, name];
}
