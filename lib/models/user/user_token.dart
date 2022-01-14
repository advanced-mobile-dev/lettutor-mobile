class UserToken {
  String accessToken;
  String refreshToken;

  UserToken({this.accessToken, this.refreshToken});

  UserToken.fromJson(Map<String, dynamic> json) {
    accessToken = json['access'] != null ? json['access']['token'] : null;
    refreshToken = json['refresh'] != null ? json['refresh']['token'] : null;
  }
}

class Token {
  String token;
  String expires;

  Token({this.token, this.expires});

  Token.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expires = json['expires'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['expires'] = this.expires;
    return data;
  }
}
