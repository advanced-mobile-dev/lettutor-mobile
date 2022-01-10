class CourseLevel {
  final int level;
  final String name;

  CourseLevel(this.level, this.name);

  static List<CourseLevel> data = <CourseLevel>[
    CourseLevel(0, 'Any Level'),
    CourseLevel(1, 'Beginner'),
    CourseLevel(2, 'Upper-Beginner'),
    CourseLevel(3, 'Pre-Intermidate'),
    CourseLevel(4, 'Intermidate'),
    CourseLevel(5, 'Upper-Intermidate'),
    CourseLevel(6, 'Pre-Advanced'),
    CourseLevel(7, 'Advanced'),
  ];
}
