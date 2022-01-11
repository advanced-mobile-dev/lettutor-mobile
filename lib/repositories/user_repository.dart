import 'package:lettutor_app/data/network/api_service.dart';
import 'package:lettutor_app/data/repository.dart';
import 'package:lettutor_app/models/student_booking/student_booking_list.dart';
import 'package:lettutor_app/models/user/user_token.dart';
import 'package:lettutor_app/models/user/user.dart';

class UserRepository {
  User _user;
  User get user => _user;

  removeUserInfo() {
    _user = null;
  }

  Future<User> getUser() async {
    final UserToken userToken = Repository.sharedPrefsHelper.userToken;
    final user = await ApiService().getUserInfo(userToken.accessToken.token);
    _user = user;
    return user;
  }

  Future<User> putUserInfo(User user) async {
    final UserToken userToken = Repository.sharedPrefsHelper.userToken;
    final resUser =
        await ApiService().putUserInfo(userToken.accessToken.token, user);
    return resUser;
  }

  Future<StudentBookingList> getBookingList(
      int perPage, int page, int dateTimeGte) async {
    final data =
        await ApiService().getStudentBooking(perPage, page, dateTimeGte);
    return data;
  }

  Future<StudentBookingList> getBookingHistory(
      int perPage, int page, int dateTimeLte) async {
    final data =
        await ApiService().getBookingHistory(perPage, page, dateTimeLte);
    return data;
  }

  Future<bool> favoriteTutor(String id) async {
    final UserToken userToken = Repository.sharedPrefsHelper.userToken;
    return ApiService().favoriteTutor(userToken.accessToken.token, id);
  }

  Future<bool> reportTutor(String userId, String content) async {
    final UserToken userToken = Repository.sharedPrefsHelper.userToken;
    return ApiService()
        .reportTutor(userToken.accessToken.token, userId, content);
  }

  Future<Duration> getLessonTime() async {
    final UserToken userToken = Repository.sharedPrefsHelper.userToken;
    final int total =
        await ApiService().getTotalLessonTime(userToken.accessToken.token);
    return Duration(minutes: total);
  }
}
