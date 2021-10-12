class Tutor {
  final String name;
  final String description;
  final String countryCode;
  final String avatar;
  final double rating;

  Tutor(
      {this.name,
      this.countryCode,
      this.avatar,
      this.description,
      this.rating});

  static final data = Tutor(
      name: 'Quang Hai Nguyen',
      countryCode: 'vn',
      avatar: 'assets/images/quang_hai.png',
      rating: 4.9,
      description:
          'I am a teacher of English and a lecturer at a college in HCMC. I can help you to communicate better in English and be more confident to use English. For me, to learn is to you, so you will be given many chances to practice English...');
  static final data1 = Tutor(
      name: 'Ronaldo',
      countryCode: 'pt',
      avatar: 'assets/images/ronaldo.png',
      rating: 4.7,
      description:
          'Hello there! I am an Industrial Engineer in the profession but chose to do online teaching because I love to meet different learners. I am an outgoing person and I have this passion for dealing with different people and seeing...');
  static final data2 = Tutor(
      name: 'Messi',
      countryCode: 'ar',
      avatar: 'assets/images/messi.png',
      rating: 3,
      description:
          'Being a teacher is what I live for. Making a difference in a students life, and seeing them progress and achieve their language goal, is the biggest pleasure in my life.');
  static final data3 = Tutor(
      name: 'Kevin Debruyne',
      countryCode: 'be',
      avatar: 'assets/images/kevin_debruyne.png',
      rating: 3.5,
      description:
          'Hello there! I am an Industrial Engineer in the profession but chose to do online teaching because I love to meet different learners. I am an outgoing person and I have this passion for dealing with different people and seeing...');
}
