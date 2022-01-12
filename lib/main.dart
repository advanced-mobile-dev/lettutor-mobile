import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/app_settings/app_settings_bloc.dart';
import 'package:lettutor_app/config/config.dart';
import 'package:lettutor_app/repositories/app_settings_repo.dart';
import 'package:lettutor_app/repositories/payment_repo.dart';
import 'package:lettutor_app/repositories/user_repository.dart';
import 'blocs/authentication/authentication_bloc.dart';
import 'data/repository.dart';
import 'repositories/authentication_repo.dart';
import 'repositories/tutor_repo.dart';
import 'utils/bloc_observer.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  await AppConfig.readCountriesFromJson();
  await Repository.init();

  final _authRepo = AuthenticationRepository();
  final _appSettingsRepo = AppSettingsRepository();
  final _userRepo = UserRepository();

  BlocOverrides.runZoned(
    () => runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => _authRepo),
        RepositoryProvider(create: (_) => _appSettingsRepo),
        RepositoryProvider(create: (_) => _userRepo),
        RepositoryProvider(create: (_) => TutorRepository()),
        RepositoryProvider(create: (_) => PaymentRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => AuthenticationBloc(
                    authenticationRepository: _authRepo,
                    userRepository: _userRepo,
                  )),
          BlocProvider(create: (_) => AppSettingsBloc(_appSettingsRepo))
        ],
        child: App(),
      ),
    )),
    blocObserver: AppBlocObserver(),
  );
}
