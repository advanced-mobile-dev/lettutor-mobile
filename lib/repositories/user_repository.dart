import 'package:lettutor_app/data/network/api_service.dart';
import 'package:lettutor_app/data/repository.dart';
import 'package:lettutor_app/models/user/user_token.dart';
import 'package:lettutor_app/models/user/user.dart';

class UserRepository {
  Future<User> getUser() async {
    final UserToken userToken = Repository.sharedPrefsHelper.userToken;
    final user = await ApiService().getUserInfo(userToken.accessToken.token);
    return user;
  }
}
