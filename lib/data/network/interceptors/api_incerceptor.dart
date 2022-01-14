import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:lettutor_app/repositories/authentication_repository.dart';
import 'package:lettutor_app/utils/key_service.dart';

class ApiInterceptor implements InterceptorContract {
  final AuthenticationRepository authenticationRepository;
  ApiInterceptor({this.authenticationRepository});
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    try {
      data.headers[HttpHeaders.contentTypeHeader] = "application/json";
    } catch (_) {}
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    if (data.statusCode == 401) {
      await showDialog(
          context: KeyService.navigatorKey.currentContext,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
                title: Row(
                  children: [
                    Icon(
                      Icons.cancel,
                      size: 36,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text("Warning")
                  ],
                ),
                content: Text("Session expired, please login again!!!"),
                actions: [
                  TextButton(
                    child: Text('Login now'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ));
      authenticationRepository.logout();
    }
    return data;
  }
}
