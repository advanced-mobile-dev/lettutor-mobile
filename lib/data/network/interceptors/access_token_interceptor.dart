import 'dart:io';

import 'package:http_interceptor/http/http.dart';
import 'package:http_interceptor/models/response_data.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:lettutor_app/data/shared_preferences/shared_prefs_provider.dart';

class AccessTokenInterceptor implements InterceptorContract {
  final SharedPrefsHelper sharedPrefsHelper;
  AccessTokenInterceptor(this.sharedPrefsHelper);

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    final token = sharedPrefsHelper.userToken.accessToken;
    data.headers[HttpHeaders.authorizationHeader] = "Bearer $token";
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    return data;
  }
}
