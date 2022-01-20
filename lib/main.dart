import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/src/repository_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:lettutor_app/constants/config.dart';
import 'package:lettutor_app/data/network/apis/authentication_api_client.dart';
import 'package:lettutor_app/data/network/apis/user_api_client.dart';
import 'package:lettutor_app/data/network/interceptors/access_token_interceptor.dart';
import 'package:lettutor_app/data/network/interceptors/api_incerceptor.dart';
import 'package:lettutor_app/data/network/interceptors/expired_retry_token_policy.dart';
import 'package:lettutor_app/repositories/app_settings_repository.dart';
import 'package:lettutor_app/repositories/payment_repository.dart';
import 'package:lettutor_app/repositories/user_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/network/apis/course_api_client.dart';
import 'data/network/apis/payment_api_client.dart';
import 'data/network/apis/tutor_api_client.dart';
import 'data/shared_preferences/shared_prefs_provider.dart';
import 'repositories/authentication_repository.dart';
import 'repositories/course_repository.dart';
import 'repositories/tutor_repository.dart';
import 'utils/bloc_observer.dart';
import 'app.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    await AppConfig.readCountriesFromJson();

    final repositoryProviders = await getRepositoryProviders();
    await SentryFlutter.init(
        (options) => options.dsn =
            'https://f2cd6131329e4b378e34e267647cdae2@o1099429.ingest.sentry.io/6158180',
        appRunner: () => BlocOverrides.runZoned(
              () => runApp(MultiRepositoryProvider(
                  providers: repositoryProviders, child: App())),
              blocObserver: AppBlocObserver(),
            ));
  }, (exception, stackTrace) async {
    await Sentry.captureException(exception, stackTrace: stackTrace);
  });
}

Future<List<RepositoryProviderSingleChildWidget>>
    getRepositoryProviders() async {
  final _sharedPrefsHelper =
      SharedPrefsHelper(await SharedPreferences.getInstance());
  final unAuthenticatedHttpClient = InterceptedClient.build(interceptors: [
    ApiInterceptor(),
  ]);

  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository(
          sharedPrefsHelper: _sharedPrefsHelper,
          authenticationApiClient:
              AuthenticationApiClient(httpClient: unAuthenticatedHttpClient));

  final authenticatedHttpClient = InterceptedClient.build(
      interceptors: [
        ApiInterceptor(authenticationRepository: _authenticationRepository),
        AccessTokenInterceptor(_sharedPrefsHelper),
      ],
      retryPolicy: ExpiredTokenRetryPolicy(
          authenticationRepository: _authenticationRepository));

  final AppSettingsRepository _appSettingsRepository =
      AppSettingsRepository(sharedPrefsHelper: _sharedPrefsHelper);

  final UserRepository _userRepository = UserRepository(
      userApiClient: UserApiClient(httpClient: authenticatedHttpClient));

  final TutorRepository _tutorRepository = TutorRepository(
      tutorApiClient: TutorApiClient(httpClient: authenticatedHttpClient));

  final CourseRepository _courseRepository = CourseRepository(
      courseApiClient: CourseApiClient(httpClient: authenticatedHttpClient));

  final PaymentRepository _paymentRepository = PaymentRepository(
      paymentApiClient: PaymentApiClient(httpClient: authenticatedHttpClient));

  return [
    RepositoryProvider(create: (_) => _authenticationRepository),
    RepositoryProvider(create: (_) => _appSettingsRepository),
    RepositoryProvider(create: (_) => _userRepository),
    RepositoryProvider(create: (_) => _tutorRepository),
    RepositoryProvider(create: (_) => _courseRepository),
    RepositoryProvider(create: (_) => _paymentRepository),
  ];
}
