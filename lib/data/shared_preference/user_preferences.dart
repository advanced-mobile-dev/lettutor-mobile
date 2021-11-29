import 'package:lettutor_app/data/shared_preference/constants/preferences.dart';
import 'package:lettutor_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(Preferences.user_id);
    prefs.remove(Preferences.user_name);
    prefs.remove(Preferences.user_email);
    prefs.remove(Preferences.user_avatar);
    prefs.remove(Preferences.user_token);
    prefs.remove(Preferences.user_refreshtoken);
    prefs.remove(Preferences.is_logged_in);
  }

  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(Preferences.user_id, user.userId);
    prefs.setString(Preferences.user_name, user.name);
    prefs.setString(Preferences.user_email, user.email);
    prefs.setString(Preferences.user_avatar, user.avatar);
    prefs.setString(Preferences.user_token, user.token);
    prefs.setString(Preferences.user_refreshtoken, user.refreshToken);
    prefs.setBool(Preferences.is_logged_in, true);
    return true;
  }

  Future<User> get user async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int id = prefs.getInt(Preferences.user_id);
    String name = prefs.getString(Preferences.user_name);
    String email = prefs.getString(Preferences.user_email);
    String avatar = prefs.getString(Preferences.user_avatar);
    String token = prefs.getString(Preferences.user_token);
    String refreshToken = prefs.getString(Preferences.user_refreshtoken);

    return User(
        userId: id,
        name: name,
        email: email,
        avatar: avatar,
        token: token,
        refreshToken: refreshToken);
  }

  Future<bool> get isLoggedIn async {
    print('1');
    final sharedPreference = await SharedPreferences.getInstance();
    print('2');
    return sharedPreference.getBool(Preferences.is_logged_in) ?? false;
  }

  Future<String> get authToken async {
    final sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference.getString(Preferences.auth_token);
  }

  Future<bool> saveAuthToken(String authToken) async {
    final sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference.setString(Preferences.auth_token, authToken);
  }

  Future<bool> removeAuthToken() async {
    final sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference.remove(Preferences.auth_token);
  }
}
