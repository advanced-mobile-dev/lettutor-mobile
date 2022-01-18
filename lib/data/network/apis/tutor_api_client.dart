import 'dart:convert';
import 'package:http/http.dart';
import 'package:lettutor_app/data/network/rest_client.dart';
import 'package:lettutor_app/models/schedule/tutor_schedule_list.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';
import 'package:lettutor_app/models/tutor/tutor_basic_info.dart';
import 'package:lettutor_app/models/tutor/tutor_list.dart';

class TutorApiClient {
  final BaseClient httpClient;
  RestClient _restClient;
  TutorApiClient({this.httpClient}) {
    _restClient = RestClient(httpClient);
  }

  Future<TutorList> getTutors(
      int perPage, int page, List<String> specialties, String keyword) async {
    final String endpoint = '/tutor/search';
    final Response response = await _restClient.post('$endpoint', body: {
      "filters": {
        "specialties": specialties,
      },
      "perPage": perPage,
      "page": page,
      "search": keyword
    });
    if (response.statusCode == 200) {
      final TutorList tutorList = TutorList.fromJson(jsonDecode(response.body));
      return tutorList;
    }
    return null;
  }

  Future<Tutor> getTutorById(String id) async {
    final String endpoint = '/tutor/$id';
    final Response response = await _restClient.get('$endpoint');
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final Tutor tutor = Tutor.fromJson(body);
      TutorBasicInfo tutorBasicInfo =
          TutorBasicInfo.fromJson(body['User'] ?? {});
      tutor.tutorBasicInfo = tutorBasicInfo;
      return tutor;
    }
    return null;
  }

  Future<TutorScheduleList> fetchTutorSchedules(String tutorId) async {
    final String endpoint = '/schedule';
    final Response response =
        await _restClient.post('$endpoint', body: {"tutorId": tutorId});
    if (response.statusCode == 200) {
      return TutorScheduleList.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<double> getPriceOfSession() async {
    return 100;
  }
}
