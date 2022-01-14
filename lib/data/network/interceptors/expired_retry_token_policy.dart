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
      print("Retrying request...${DateTime.now().microsecondsSinceEpoch}");
      // await authenticationRepository.refreshToken();
      await Future.delayed(Duration(seconds: 5));
      return true;
    }

    return false;
  }
}
