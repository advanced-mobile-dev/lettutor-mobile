import 'package:lettutor_app/data/network/api_service.dart';
import 'package:lettutor_app/data/repository.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';
import 'package:lettutor_app/models/user/user_token.dart';

class TutorRepository {
  Future<Tutor> getTutor(String id) async {
    final UserToken userToken = Repository.sharedPrefsHelper.userToken;
    final tutor =
        await ApiService().getTutorById(userToken.accessToken.token, id);
    return tutor;
  }
}
