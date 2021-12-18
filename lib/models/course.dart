class CourseTmp {
  final String name;
  final String shortDescription;
  final String overview;
  final String experienceLevel;
  final int courseLength;
  final List<String> topics;
  final String image;

  CourseTmp(
      {this.name,
      this.shortDescription,
      this.overview,
      this.experienceLevel,
      this.courseLength,
      this.topics,
      this.image});

  static final List<CourseTmp> courseList = [
    CourseTmp(
        name: 'IELTS Speaking Part 2',
        shortDescription:
            'Practice answering Part 2 questions from past years IELTS exams',
        overview:
            'Answering open-ended questions asked by a native speaker is the best way to simulate Part 3 of the IELTS speaking exam.',
        experienceLevel: 'Any level',
        courseLength: 8,
        topics: [
          'Holidays and Vacations',
          'Art',
          'Education',
          'News and Media',
          'Nature and Environment',
          'Friends',
          'Food and Restaurants',
          'Technology'
        ],
        image: 'assets/images/course_01.png'),
    CourseTmp(
        name: 'Workshop: Practicing Presentations',
        shortDescription: 'Practice an upcoming presentation or speech',
        overview:
            'Answering open-ended questions asked by a native speaker is the best way to simulate Part 3 of the IELTS speaking exam.',
        experienceLevel: 'Any level',
        courseLength: 4,
        topics: [
          'Organization and Pacing',
          'Vocabulary and Grammar',
          'Delivery',
          'Full Mock Presentation',
        ],
        image: 'assets/images/course_02.png'),
  ];
}
