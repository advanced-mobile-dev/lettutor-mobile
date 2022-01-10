import 'dart:convert';

import 'package:http/http.dart';
import 'package:lettutor_app/data/network/rest_client.dart';
import 'package:lettutor_app/data/repository.dart';
import 'package:lettutor_app/models/course/course_level.dart';
import 'package:lettutor_app/models/course/category.dart';
import 'package:lettutor_app/models/course/course_list.dart';
import 'package:lettutor_app/models/schedule/booking_info.dart';
import 'package:lettutor_app/models/schedule/schedule_detail.dart';
import 'package:lettutor_app/models/student_booking/student_booking.dart';
import 'package:lettutor_app/models/student_booking/student_booking_list.dart';
import 'package:lettutor_app/models/tutor/tutor_list.dart';
import 'package:lettutor_app/models/tutor_schedule/tutor_schedule_list.dart';
import 'package:lettutor_app/models/user/user_token.dart';
import 'package:lettutor_app/models/user/user.dart';
import 'package:lettutor_app/screens/dash_board/tabs/courses/widgets/course_list_widget.dart';

class ApiService {
  static final RestClient _apiClient = RestClient();

  Future<User> login(String email, String password) async {
    final String endpoint = '/auth/login';
    final body = {"email": email, "password": password};
    final Response response = await _apiClient.post('$endpoint', body: body);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final User user = User.fromJson(body['user']);
      user.userToken = UserToken.fromJson(body['tokens']);
      return user;
    }
    return null;
  }

  facebookLogin(String token) async {
    final String endpoint = '/auth/facebook';
    final Response response = await _apiClient.post('$endpoint', body: {
      "access_token": token,
    });
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final User user = User.fromJson(body['user']);
      user.userToken = UserToken.fromJson(body['tokens']);
      return user;
    }
    return null;
  }

  googleLogin(String token) async {
    final String endpoint = '/auth/google';
    final Response response = await _apiClient.post('$endpoint', body: {
      "access_token": token,
    });
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final User user = User.fromJson(body['user']);
      user.userToken = UserToken.fromJson(body['tokens']);
      return user;
    }
    return null;
  }

  getUserInfo(String token) async {
    final String endpoint = '/user/info';
    final Response response = await _apiClient
        .get('$endpoint', headers: {"Authorization": 'Bearer $token'});
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final User user = User.fromJson(body['user']);
      return user;
    }
    return null;
  }

  Future<TutorList> getTutors(String accessToken, int perPage, int page,
      List<String> specialties) async {
    final String endpoint = '/tutor/search';
    final Response response = await _apiClient.post('$endpoint', headers: {
      "Authorization": 'Bearer $accessToken',
    }, body: {
      "filters": {
        "specialties": specialties,
      },
      "perPage": perPage,
      "page": page
    });
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final TutorList tutorList = TutorList.fromJson(body);
      return tutorList;
    }
    return null;
  }

  Future<User> signUp(String email, String password) async {
    final String endpoint = '/auth/register';
    final body = {"email": email, "password": password};
    final Response response = await _apiClient.post('$endpoint', body: body);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final User user = User.fromJson(body['user']);
      user.userToken = UserToken.fromJson(body['tokens']);
      return user;
    }
    return null;
  }

  Future<User> putUserInfo(String token, User user) async {
    final String endpoint = '/user/info';
    // print(user.toJsonForPut());
    final Response response = await _apiClient.put('$endpoint',
        headers: {"Authorization": 'Bearer $token'}, body: user.toJsonForPut());
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final User user = User.fromJson(body['user']);
      return user;
    }
    return null;
  }

  fetchTutorSchedules(String tutorId) async {
    final accessToken = Repository.userToken.accessToken.token;
    final String endpoint = '/schedule';
    final Response response = await _apiClient.post('$endpoint', headers: {
      "Authorization": 'Bearer $accessToken',
    }, body: {
      "tutorId": tutorId
    });
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      // final List<TutorSchedule> tutorSchedules =
      //     (body['data'] as List).map((e) => TutorSchedule.fromJson(e)).toList();
      // print(tutorSchedules);

      return TutorScheduleList.fromJson(body);
    }
    return null;
  }

  bookTutorClass(ScheduleDetail scheduleDetail) {}

  bookClass(String scheduleDetailid, String note) async {
    final accessToken = Repository.userToken.accessToken.token;
    final String endpoint = '/booking';
    final Response response = await _apiClient.post('$endpoint', headers: {
      "Authorization": 'Bearer $accessToken',
    }, body: {
      "scheduleDetailIds": [scheduleDetailid],
      "note": note
    });
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return (body['data'] as List)
          .map((e) => BookingInfo.fromJson(e))
          .toList();
    }
    return <BookingInfo>[];
  }

  Future<double> getPriceOfSession() async {
    return 100;
  }

  getStudentBooking(int perPage, int page, int dateTimeGte) async {
    final accessToken = Repository.userToken.accessToken.token;
    final String endpoint = '/booking/list/student';
    final Response response = await _apiClient.get('$endpoint', headers: {
      "Authorization": 'Bearer $accessToken',
    }, params: {
      'page': '$page',
      'perPage': '$perPage',
      'dateTimeGte': '$dateTimeGte',
      'orderBy': 'meeting',
      'sortBy': 'asc',
    });
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final StudentBookingList bookingList =
          StudentBookingList.fromJson(body['data']);
      return bookingList;
    }
    return null;
  }

  getBookingHistory(int perPage, int page, int dateTimeLte) async {
    final accessToken = Repository.userToken.accessToken.token;
    final String endpoint = '/booking/list/student';
    final Response response = await _apiClient.get('$endpoint', headers: {
      "Authorization": 'Bearer $accessToken',
    }, params: {
      'page': '$page',
      'perPage': '$perPage',
      'dateTimeLte': '$dateTimeLte',
      'orderBy': 'meeting',
      'sortBy': 'desc',
    });
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final StudentBookingList bookingList =
          StudentBookingList.fromJson(body['data']);
      return bookingList;
    }
    return null;
  }

  getCourses(
      String accessToken,
      int perPage,
      int page,
      List<CourseLevel> levels,
      List<Category> categories,
      String keyword) async {
    final String endpoint = '/course';
    Map<String, dynamic> _params = {
      "size": '$perPage',
      "page": '$page',
      "q": '$keyword',
      "level[]": levels.map((e) => '${e.level}').toList(),
      "categoryId[]": categories.map((e) => '${e.id}').toList(),
    };
    final Response response = await _apiClient.get('$endpoint',
        headers: {
          "Authorization": 'Bearer $accessToken',
        },
        params: _params);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      print(body);
      final CourseList tutorList = CourseList.fromJson(body['data']);
      print(tutorList.count);
      return tutorList;
    }
    return null;
  }
}
