import 'package:lettutor_app/data/network/api_service.dart';
import 'package:lettutor_app/data/repository.dart';
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
}
