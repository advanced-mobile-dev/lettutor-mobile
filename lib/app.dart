import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lettutor_app/blocs/app_settings/app_settings_bloc.dart';
import 'package:lettutor_app/routes.dart';
import 'blocs/authentication/authentication_bloc.dart';
import 'config/colors.dart';
import 'config/languages.dart';
import 'config/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatelessWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryColor[50],
    ));
    return BlocBuilder<AppSettingsBloc, AppSettingsState>(
        builder: (context, state) {
      return MaterialApp(
        navigatorKey: navigatorKey,
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
        theme: state.isDarkTheme ? AppTheme.themeDataDark : AppTheme.themeData,
        routes: registerRoutes(),
        onGenerateRoute: registerRoutesWithParameters,
        builder: (context, child) {
          return BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is UnknownState) {
                navigatorKey.currentState.pushNamedAndRemoveUntil(
                    LettutorRoutes.start, (route) => false);
              }
              if (state is UnAuthenticatedState) {
                navigatorKey.currentState.pushNamedAndRemoveUntil(
                    LettutorRoutes.start, (route) => false);
              }
              if (state is AuthenticatedState) {
                navigatorKey.currentState.pushNamedAndRemoveUntil(
                    LettutorRoutes.home, (route) => false);
              }
            },
            child: child,
          );
        },
      );
    });
  }
}
