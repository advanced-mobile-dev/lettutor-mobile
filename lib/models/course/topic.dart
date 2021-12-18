class Topic {
  String id;
  String courseId;
  int orderCourse;
  String name;
  String nameFile;
  String description;
  String videoUrl;
  String createdAt;
  String updatedAt;

  Topic(
      {this.id,
      this.courseId,
      this.orderCourse,
      this.name,
      this.nameFile,
      this.description,
      this.videoUrl,
      this.createdAt,
      this.updatedAt});

  Topic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['courseId'];
    orderCourse = json['orderCourse'];
    name = json['name'];
    nameFile = json['nameFile'];
    description = json['description'];
    videoUrl = json['videoUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['courseId'] = this.courseId;
    data['orderCourse'] = this.orderCourse;
    data['name'] = this.name;
    data['nameFile'] = this.nameFile;
    data['description'] = this.description;
    data['videoUrl'] = this.videoUrl;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
