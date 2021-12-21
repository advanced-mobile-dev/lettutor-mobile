class UserTmp {
  final String userId;
  final String name;
  final String email;
  final String avatar;
  final String token;
  final String refreshToken;

  UserTmp(
      {this.userId,
      this.name,
      this.email,
      this.avatar,
      this.token,
      this.refreshToken});

  static final data = UserTmp(
      userId: '1',
      name: 'Hieu Ho',
      email: 'hohieu1099@gmail.com',
      avatar: 'assets/images/kevin_debruyne.png',
      token: 'token',
      refreshToken: 'refreshToken');
}
