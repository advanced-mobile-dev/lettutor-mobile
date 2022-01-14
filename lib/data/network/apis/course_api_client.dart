import 'dart:convert';
import 'package:http/http.dart';
import 'package:lettutor_app/data/network/rest_client.dart';
import 'package:lettutor_app/models/course/category.dart';
import 'package:lettutor_app/models/course/course_level.dart';
import 'package:lettutor_app/models/course/course_list.dart';

class CourseApiClient {
  final BaseClient httpClient;
  RestClient _restClient;
  CourseApiClient({this.httpClient}) {
    _restClient = RestClient(httpClient);
  }

  Future<CourseList> getCourses(int perPage, int page, List<CourseLevel> levels,
      List<Category> categories, String keyword) async {
    final String endpoint = '/course';
    Map<String, dynamic> _params = {
      "size": '$perPage',
      "page": '$page',
      "q": '${keyword ?? ''}',
      "level[]": levels.map((e) => '${e.level}').toList(),
      "categoryId[]": categories.map((e) => '${e.id}').toList(),
    };
    final Response response =
        await _restClient.get('$endpoint', params: _params);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final CourseList tutorList = CourseList.fromJson(body['data']);
      return tutorList;
    }
    return null;
  }
}
