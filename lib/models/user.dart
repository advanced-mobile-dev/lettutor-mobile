class User {
  final String name;
  final String email;
  final String avatar;

  User({
    this.name,
    this.email,
    this.avatar,
  });

  static final data = User(
      name: 'Hieu Ho',
      email: 'hohieu1099@gmail.com',
      avatar: 'assets/images/kevin_debruyne.png');
}
