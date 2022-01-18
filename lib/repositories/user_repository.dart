import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lettutor_app/data/network/apis/user_api_client.dart';
import 'package:lettutor_app/data/shared_preferences/shared_prefs_provider.dart';
import 'package:lettutor_app/models/booking/booking_list.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';
import 'package:lettutor_app/models/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  final UserApiClient userApiClient;
  UserRepository({@required this.userApiClient});

  User _user;
  User get user => _user;

  removeUserInfo() {
    _user = null;
  }

  Future<User> getUser() async {
    final resUser = await userApiClient.getUserInfo();
    if (resUser != null) _user = resUser;
    return resUser;
  }

  Future<User> putUserInfo(User user, XFile avatar) async {
    if (avatar != null) {
      final sharedPrefsHelper =
          SharedPrefsHelper(await SharedPreferences.getInstance());
      final putUserInfo = userApiClient.putUserInfo(user);
      final putAvatar = userApiClient.putUserAvatar(
          sharedPrefsHelper.userToken.accessToken, avatar);
      final results = await Future.wait([putUserInfo, putAvatar]);
      if (results != null && results.length == 2) {
        if (results[0] != null) _user = results[0];
        if (results[1] != null) _user = results[1];
        return results[1];
      }
      return null;
    } else {
      final resUser = await userApiClient.putUserInfo(user);
      if (resUser != null) _user = resUser;
      return resUser;
    }
  }

  Future<BookingList> getBookingList(
      int perPage, int page, int dateTimeGte) async {
    final data = await userApiClient.getUserBooking(perPage, page, dateTimeGte);
    return data;
  }

  Future<BookingList> getBookingHistory(
      int perPage, int page, int dateTimeLte) async {
    return await userApiClient.getBookingHistory(perPage, page, dateTimeLte);
  }

  Future<bool> favoriteTutor(String id) async {
    return userApiClient.favoriteTutor(id);
  }

  Future<bool> reportTutor(String userId, String content) async {
    return userApiClient.reportTutor(userId, content);
  }

  Future<Duration> getLessonTime() async {
    return Duration(minutes: await userApiClient.getTotalLessonTime());
  }

  Future<List<Tutor>> getFavoriteList() async {
    return await userApiClient.getFavoriteList();
  }

  Future<bool> cancelMeeting(String scheduleId) async {
    return userApiClient.cancelMeeting(scheduleId);
  }
}
