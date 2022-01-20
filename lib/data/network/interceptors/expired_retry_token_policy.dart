import 'package:http_interceptor/http_interceptor.dart';
import 'package:lettutor_app/repositories/authentication_repository.dart';

class ExpiredTokenRetryPolicy extends RetryPolicy {
  final AuthenticationRepository authenticationRepository;
  ExpiredTokenRetryPolicy({this.authenticationRepository});
  @override
  int get maxRetryAttempts => 2;

  @override
  bool shouldAttemptRetryOnException(Exception reason) {
    print(reason);
    return false;
  }

  @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    if (response.statusCode == 401) {
      print("Refresh token...${DateTime.now().microsecondsSinceEpoch}");
      final user = await authenticationRepository.refreshToken();
      if (user == null) {
        return true;
      }
    }

    return false;
  }
}
