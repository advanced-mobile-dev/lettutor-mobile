import 'package:lettutor_app/data/network/api-service.dart';
import 'package:lettutor_app/data/repository.dart';
import 'package:lettutor_app/models/user/user-token.dart';
import 'package:lettutor_app/models/user/user.dart';

class UserRepository {
  User _user;

  Future<User> getUser() async {
    if (_user != null) return _user;
    final UserToken userToken = Repository.sharedPrefsHelper.userToken;
    final user = await ApiService().getUserInfo(userToken.accessToken.token);
    _user = user;
    return user;
  }
}
