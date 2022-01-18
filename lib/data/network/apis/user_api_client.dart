import 'dart:convert';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:lettutor_app/data/network/rest_client.dart';
import 'package:lettutor_app/models/booking/booking_list.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';
import 'package:lettutor_app/models/tutor/tutor_basic_info.dart';
import 'package:lettutor_app/models/user/user.dart';

class UserApiClient {
  final BaseClient httpClient;
  RestClient _restClient;
  UserApiClient({this.httpClient}) {
    _restClient = new RestClient(httpClient);
  }

  getUserInfo() async {
    final String endpoint = '/user/info';
    final Response response = await _restClient.get(
      '$endpoint',
    );
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final User user = User.fromJson(body['user']);
      return user;
    }
    return null;
  }

  Future<User> putUserInfo(User user) async {
    final String endpoint = '/user/info';
    final Response response =
        await _restClient.put('$endpoint', body: user.toJsonForPut());
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final User user = User.fromJson(body['user']);
      return user;
    }
    return null;
  }

  Future<User> putUserAvatar(String token, XFile avatar) async {
    final String endpoint = '/user/uploadAvatar';

    var uri = Uri.https('sandbox.api.lettutor.com', endpoint, {});
    final imagePath = avatar.path.split('.').last;
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('avatar', avatar.path,
          contentType: new MediaType('image', imagePath)))
      ..headers.addAll({
        "Authorization": 'Bearer $token',
      });
    var response = await request.send().timeout(Duration(seconds: 20));

    if (response.statusCode == 200) {
      final body = await response.stream.bytesToString();
      return User.fromJson(jsonDecode(body));
    }
    return null;
  }

  Future<BookingList> getUserBooking(
      int perPage, int page, int dateTimeGte) async {
    final String endpoint = '/booking/list/student';
    final Response response = await _restClient.get('$endpoint', params: {
      'page': '$page',
      'perPage': '$perPage',
      'dateTimeGte': '$dateTimeGte',
      'orderBy': 'meeting',
      'sortBy': 'asc',
    });
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final BookingList bookingList = BookingList.fromJson(body['data']);
      return bookingList;
    }
    return null;
  }

  getBookingHistory(int perPage, int page, int dateTimeLte) async {
    final String endpoint = '/booking/list/student';
    final Response response = await _restClient.get('$endpoint', params: {
      'page': '$page',
      'perPage': '$perPage',
      'dateTimeLte': '$dateTimeLte',
      'orderBy': 'meeting',
      'sortBy': 'desc',
    });
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final BookingList bookingList = BookingList.fromJson(body['data']);
      return bookingList;
    }
    return null;
  }

  Future<bool> favoriteTutor(String id) async {
    final String endpoint = '/user/manageFavoriteTutor';
    final body = {"tutorId": id};
    final Response response = await _restClient.post(
      '$endpoint',
      body: body,
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> reportTutor(String userId, String content) async {
    final String endpoint = '/report';
    final body = {"tutorId": userId, 'content': content};
    final Response response = await _restClient.post(
      '$endpoint',
      body: body,
    );
    if (response.statusCode == 200) {
      print(response.body);
      return true;
    }
    return false;
  }

  Future<int> getTotalLessonTime() async {
    final String endpoint = '/call/total';
    final Response response = await _restClient.get(
      '$endpoint',
    );
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body['total'];
    }
    return null;
  }

  Future<List<Tutor>> getFavoriteList() async {
    final String endpoint = '/tutor/more';
    final Response response = await _restClient.get('$endpoint', params: {
      'perPage': '1',
      'page': '1',
    });
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List<Tutor> tutors = (body['favoriteTutor'] as List)
          .where((element) => element['secondInfo'] != null)
          .map((e) {
        final basicInfo = e['secondInfo'];
        final tutorBasicInfo = TutorBasicInfo.fromJson(basicInfo);
        final tutor = Tutor.fromJson(basicInfo['tutorInfo']);
        tutor.tutorBasicInfo = tutorBasicInfo;
        return tutor;
      }).toList();
      return tutors;
    }
    return null;
  }

  Future<bool> cancelMeeting(String scheduleId) async {
    final String endpoint = '/booking';
    final Response response = await _restClient.delete('$endpoint', body: {
      "scheduleDetailIds": [scheduleId]
    });
    if (response.statusCode == 200) {
      print(response.body);
      return true;
    }
    return false;
  }
}
