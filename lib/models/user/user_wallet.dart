class UserWallet {
  String id;
  String userId;
  double amount;
  bool isBlocked;
  String createdAt;
  String updatedAt;
  int bonus;

  UserWallet(
      {this.id,
      this.userId,
      this.amount,
      this.isBlocked,
      this.createdAt,
      this.updatedAt,
      this.bonus});

  UserWallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    amount = double.parse(json['amount']);
    isBlocked = json['isBlocked'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    bonus = json['bonus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['amount'] = this.amount;
    data['isBlocked'] = this.isBlocked;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['bonus'] = this.bonus;
    return data;
  }
}
