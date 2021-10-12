class Teacher {
  final String name;
  final String countryCode;
  final String avatar;

  Teacher({this.name, this.countryCode, this.avatar});

  static final data = Teacher(
      name: 'Quang Hai Nguyen',
      countryCode: 'vn',
      avatar: 'assets/images/quang_hai.png');
  static final data1 = Teacher(
      name: 'Ronaldo', countryCode: 'pt', avatar: 'assets/images/ronaldo.png');
  static final data2 = Teacher(
      name: 'Messi', countryCode: 'ar', avatar: 'assets/images/messi.png');
  static final data3 = Teacher(
      name: 'Kevin Debruyne',
      countryCode: 'be',
      avatar: 'assets/images/kevin_debruyne.png');
}
