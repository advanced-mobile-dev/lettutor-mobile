class Level {
  final String code;
  final String name;
  Level(this.code, this.name);
  static List<Level> data = [
    Level('BEGINNER', 'Beginner'),
    Level('HIGHER_BEGINNER', 'Higher beginner'),
    Level('PRE_INTERMEDIATE', 'Pre intermediate'),
    Level('INTERMEDIATE', 'Intermediate'),
    Level('UPPER_INTERMEDIATE', 'Upper intermediate'),
    Level('ADVANCED', 'Advanced'),
    Level('PROFICIENCY', 'Proficiency'),
  ];
}
