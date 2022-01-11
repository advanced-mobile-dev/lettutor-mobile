import 'package:lettutor_app/models/tutor/tutor_basic_info.dart';

class Tutor {
  TutorBasicInfo tutorBasicInfo;
  String id;
  String userId;
  String video;
  String bio;
  String education;
  String experience;
  String profession;
  String accent;
  String targetStudent;
  String interests;
  String languages;
  String specialties;
  String resume;
  bool isActivated;
  bool isNative;
  String createdAt;
  String updatedAt;
  bool isFavorite;
  int price;

  Tutor(
      {this.id,
      this.userId,
      this.video,
      this.bio,
      this.education,
      this.experience,
      this.profession,
      this.accent,
      this.targetStudent,
      this.interests,
      this.languages,
      this.specialties,
      this.resume,
      this.isActivated,
      this.isNative,
      this.createdAt,
      this.updatedAt,
      this.tutorBasicInfo,
      this.isFavorite,
      this.price});

  Tutor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    video = json['video'];
    bio = json['bio'];
    education = json['education'];
    experience = json['experience'];
    profession = json['profession'];
    accent = json['accent'];
    targetStudent = json['targetStudent'];
    interests = json['interests'];
    languages = json['languages'];
    specialties = json['specialties'];
    resume = json['resume'];
    isActivated = json['isActivated'];
    isNative = json['isNative'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    tutorBasicInfo = json['tutor'] != null
        ? new TutorBasicInfo.fromJson(json['tutor'])
        : null;
    isFavorite = json['isFavorite'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['video'] = this.video;
    data['bio'] = this.bio;
    data['education'] = this.education;
    data['experience'] = this.experience;
    data['profession'] = this.profession;
    data['accent'] = this.accent;
    data['targetStudent'] = this.targetStudent;
    data['interests'] = this.interests;
    data['languages'] = this.languages;
    data['specialties'] = this.specialties;
    data['resume'] = this.resume;
    data['isActivated'] = this.isActivated;
    data['isNative'] = this.isNative;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.tutorBasicInfo != null) {
      data['tutor'] = this.tutorBasicInfo.toJson();
    }
    data['isFavorite'] = this.isFavorite;
    data['price'] = this.price;
    return data;
  }
}
