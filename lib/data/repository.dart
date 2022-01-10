import 'package:lettutor_app/data/network/api_service.dart';
import 'package:lettutor_app/models/course/course_list.dart';
import 'package:lettutor_app/models/filter/course_filter.dart';
import 'package:lettutor_app/models/tutor/tutor_list.dart';
import 'package:lettutor_app/models/user/user_token.dart';
import 'package:lettutor_app/models/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared_preferences/shared_prefs_provider.dart';

class Repository {
  Repository._();
  static SharedPrefsHelper _sharedPrefsHelper;
  static ApiService _apiService;
  static init() async {
    _sharedPrefsHelper =
        SharedPrefsHelper(await SharedPreferences.getInstance());
    _apiService = ApiService();
  }

  static SharedPrefsHelper get sharedPrefsHelper => _sharedPrefsHelper;
  static get apiService => _apiService;

//app
  static void changeBrightnessToDark(bool isDarkTheme) =>
      _sharedPrefsHelper.changeBrightnessToDark(isDarkTheme);
  static void changeLanguage(String locale) =>
      _sharedPrefsHelper.changeLanguage(locale);
  static String get currentLanguageLocale =>
      _sharedPrefsHelper.currentLanguageLocale;
  static bool get isDarkMode => _sharedPrefsHelper.isDarkMode;

//auth
  static UserToken get userToken => _sharedPrefsHelper.userToken;
  static void removeUserToken() => _sharedPrefsHelper.removeUserToken();
  static void saveUserToken(UserToken userToken) =>
      _sharedPrefsHelper.saveUserToken(userToken);

  static Future<User> login(String email, String password) async {
    final user = await _apiService.login(email, password);
    if (user != null) {
      Repository.saveUserToken(user.userToken);
      return user;
    }
    return null;
  }

  static Future<User> facebookLogin(String token) async {
    final user = await _apiService.facebookLogin(token);
    if (user != null) {
      Repository.saveUserToken(user.userToken);
      return user;
    }
    return null;
  }

  static Future<User> googleLogin(String token) async {
    final user = await _apiService.googleLogin(token);
    if (user != null) {
      Repository.saveUserToken(user.userToken);
      return user;
    }
    return null;
  }

  static getUserInfo() async {
    final UserToken userToken = _sharedPrefsHelper.userToken;
    if (userToken == null) return null;
    final user = await _apiService.getUserInfo(userToken.accessToken.token);
    return user;
  }

  //
  static Future<TutorList> getTutors(
      int perPage, int page, List<String> specialties) async {
    final accessToken = _sharedPrefsHelper.userToken.accessToken.token;
    final TutorList tutors =
        await _apiService.getTutors(accessToken, perPage, page, specialties);
    return tutors;
  }

  static Future<CourseList> getCourses(
      int coursePerPage, int page, CourseFilter courseFilter) async {
    final accessToken = _sharedPrefsHelper.userToken.accessToken.token;
    final levels = courseFilter.levels;
    final categories = courseFilter.categories;
    final keyword = courseFilter.keyword;
    final CourseList courses = await _apiService.getCourses(
        accessToken, coursePerPage, page, levels, categories, keyword);
    return courses;
  }
}
