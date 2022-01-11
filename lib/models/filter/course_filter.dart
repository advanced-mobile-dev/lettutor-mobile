import 'package:lettutor_app/models/course/category.dart';
import 'package:lettutor_app/models/course/course_level.dart';

class CourseFilter {
  final List<CourseLevel> levels;
  final List<Category> categories;
  final String keyword;
  CourseFilter({this.levels, this.categories, this.keyword = ''});

  filterNumber() {
    if (levels.isEmpty) {
      if (categories.isEmpty) {
        return '';
      }
      return '1';
    } else {
      if (categories.isEmpty) {
        return '1';
      }
      return '2';
    }
  }

  CourseFilter copyWith(
      {String keyword, List<CourseLevel> levels, List<Category> categories}) {
    return CourseFilter(
      keyword: keyword ?? this.keyword,
      levels: levels ?? this.levels,
      categories: categories ?? this.categories,
    );
  }
}
