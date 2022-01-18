import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lettutor_app/blocs/app_settings/app_settings_bloc.dart';
import 'package:lettutor_app/repositories/app_settings_repository.dart';
import 'package:lettutor_app/repositories/authentication_repository.dart';
import 'package:lettutor_app/repositories/user_repository.dart';
import 'package:lettutor_app/routes.dart';
import 'package:lettutor_app/utils/key_service.dart';
import 'blocs/authentication/authentication_bloc.dart';
import 'constants/languages.dart';
import 'constants/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => AuthenticationBloc(
                  authenticationRepository:
                      context.read<AuthenticationRepository>(),
                  userRepository: context.read<UserRepository>(),
                )),
        BlocProvider(
            create: (_) =>
                AppSettingsBloc(context.read<AppSettingsRepository>()))
      ],
      child: BlocBuilder<AppSettingsBloc, AppSettingsState>(
          builder: (context, state) {
        return MaterialApp(
          navigatorKey: KeyService.navigatorKey,
          title: 'Lettutor',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: supportedLanguages.map((e) => Locale(
                e.locale,
                e.code,
              )),
          locale: Locale(state.locale),
          theme:
              state.isDarkTheme ? AppTheme.themeDataDark : AppTheme.themeData,
          routes: registerRoutes(),
          onGenerateRoute: registerRoutesWithParameters,
          builder: (context, child) {
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is UnknownState) {
                  KeyService.navigatorKey.currentState.pushNamedAndRemoveUntil(
                      LettutorRoutes.start, (route) => false);
                }
                if (state is UnAuthenticatedState) {
                  KeyService.navigatorKey.currentState.pushNamedAndRemoveUntil(
                      LettutorRoutes.start, (route) => false);
                }
                if (state is AuthenticatedState) {
                  KeyService.navigatorKey.currentState.pushNamedAndRemoveUntil(
                      LettutorRoutes.home, (route) => false);
                }
              },
              child: child,
            );
          },
        );
      }),
    );
  }
}
