class UserLearnTopic {
  int id;
  String key;
  String name;

  UserLearnTopic({this.id, this.key, this.name});

  UserLearnTopic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['name'] = this.name;
    return data;
  }
}
