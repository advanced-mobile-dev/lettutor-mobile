class UserToken {
  Token accessToken;
  Token refreshToken;

  UserToken({this.accessToken, this.refreshToken});

  UserToken.fromJson(Map<String, dynamic> json) {
    accessToken =
        json['access'] != null ? new Token.fromJson(json['access']) : null;
    refreshToken =
        json['refresh'] != null ? new Token.fromJson(json['refresh']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.accessToken != null) {
      data['access'] = this.accessToken.toJson();
    }
    if (this.refreshToken != null) {
      data['refresh'] = this.refreshToken.toJson();
    }
    return data;
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
