import 'package:flutter/material.dart';
import 'package:lettutor_app/config/colors.dart';
import 'package:lettutor_app/config/languages.dart';
import 'package:lettutor_app/config/routes.dart';
import 'package:lettutor_app/config/theme.dart';
import 'package:lettutor_app/data/repository.dart';
import 'package:lettutor_app/models/course.dart';
import 'package:lettutor_app/providers/app-settings-provider.dart';
import 'package:lettutor_app/providers/user-provider.dart';
import 'package:lettutor_app/screens/authentication/forget_password_screen.dart';
import 'package:lettutor_app/screens/authentication/loading_screen.dart';
import 'package:lettutor_app/screens/authentication/start_screen.dart';
import 'package:flutter/services.dart';
import 'package:lettutor_app/screens/login/log_in_screen.dart';
import 'package:lettutor_app/screens/authentication/sign_up_screen.dart';
import 'package:lettutor_app/screens/home/courses/course_detail/course_detail_screen.dart';
import 'package:lettutor_app/screens/home/home_screen.dart';
import 'package:lettutor_app/screens/home/schedule/history_screen.dart';
import 'package:lettutor_app/screens/home/schedule/video_conference.dart';
import 'package:lettutor_app/screens/home/settings/language_setting_screen.dart';
import 'package:lettutor_app/screens/home/settings/password_change_screen.dart';
import 'package:lettutor_app/screens/home/settings/profile_edit_screen.dart';
import 'package:lettutor_app/screens/home/tutors/tutor_detail/booking_screen.dart';
import 'package:lettutor_app/screens/home/tutors/tutor_detail/tutor_calendar_screen.dart';
import 'package:lettutor_app/screens/home/tutors/tutor_detail/tutor_description.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'models/tutor/tutor.dart';
import 'providers/tutor-provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  await Repository.init();
  final userProvider = new UserProvider();
  await userProvider.init();
  return runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: userProvider),
    ChangeNotifierProvider(
        create: (_) => AppSettingsProvider(
            Repository.isDarkMode, Repository.currentLanguageLocale)),
    ChangeNotifierProvider(create: (_) => TutorProvider())
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryColor[50],
    ));
    final userProvider = context.read<UserProvider>();
    final appSettingsProvider = context.watch<AppSettingsProvider>();

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
      locale: Locale(appSettingsProvider.locale),
      theme: appSettingsProvider.isDarkTheme
          ? AppTheme.themeDataDark
          : AppTheme.themeData,
      routes: _registerRoutes(),
      initialRoute: userProvider.loggedInStatus == AuthStatus.NotLoggedIn
          ? LettutorRoutes.start
          : LettutorRoutes.home,
      onGenerateRoute: _registerRoutesWithParameters,
    );
  }

  Map<String, WidgetBuilder> _registerRoutes() {
    return <String, WidgetBuilder>{
      LettutorRoutes.home: (context) => HomeScreen(),
      LettutorRoutes.loading: (context) => LoadingScreen(),
      LettutorRoutes.start: (context) => StartScreen(),
      LettutorRoutes.signUp: (context) => SignUpScreen(),
      LettutorRoutes.signIn: (context) => LoginScreen(),
      LettutorRoutes.history: (context) => HistoryScreen(),
      LettutorRoutes.tutorProfile: (context) => TutorDescription(),
      LettutorRoutes.userProfile: (context) => ProfileEditScreen(),
      LettutorRoutes.changePassword: (context) => PasswordChangeScreen(),
      LettutorRoutes.languageSetting: (context) => LanguageSettingScreen(),
      LettutorRoutes.forgetPassword: (context) => ForgetPasswordScreen(),
      LettutorRoutes.videoConference: (context) => VideoConference(),
    };
  }

  Route<dynamic> _registerRoutesWithParameters(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case LettutorRoutes.booking:
        final args = routeSettings.arguments as BookingScreenArguments;
        print(args.time);
        return MaterialPageRoute(
          builder: (context) =>
              BookingScreen(tutor: args.tutor, time: args.time),
        );

        break;

      case LettutorRoutes.courseDetail:
        final courseDetail = routeSettings.arguments as CourseTmp;
        return MaterialPageRoute(
            builder: (context) => CourseDetailScreen(course: courseDetail));

        break;

      case LettutorRoutes.tutorCalendar:
        final tutor = routeSettings.arguments as Tutor;
        return MaterialPageRoute(
            builder: (context) => TutorCalendarScreen(tutor: tutor));

        break;
    }

    // return ErrorScreen();
    return null;
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StartScreen();
  }
}
