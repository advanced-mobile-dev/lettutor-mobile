import 'package:flutter/material.dart';
import 'package:lettutor_app/config/routes.dart';
import 'package:lettutor_app/config/screen_arguments.dart';
import 'package:lettutor_app/config/theme.dart';
import 'package:lettutor_app/data/shared_preference/user_preferences.dart';
import 'package:lettutor_app/models/course.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/models/user.dart';
import 'package:lettutor_app/providers/auth-provider.dart';
import 'package:lettutor_app/providers/user-provider.dart';
import 'package:lettutor_app/screens/authentication/forget_password_screen.dart';
import 'package:lettutor_app/screens/authentication/start_screen.dart';
import 'package:flutter/services.dart';
import 'package:lettutor_app/screens/authentication/log_in_screen.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppTheme.secondaryColor,
    ));
    Future<User> getUser() => UserPreferences().user;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
        ],
        child: MaterialApp(
          title: 'Lettutor',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.blue,
              backgroundColor: Colors.white,
              primaryColor: AppTheme.primaryColor),
          routes: _registerRoutes(),
          // home: FutureBuilder<User>(
          //     future: getUser(),
          //     builder: (context, snapshot) {
          //       switch (snapshot.connectionState) {
          //         case ConnectionState.none:
          //         case ConnectionState.waiting:
          //           return CircularProgressIndicator();
          //           break;
          //         default:
          //           if (snapshot.hasData) {
          //             if (snapshot.data.token == null) return StartScreen();
          //             Provider.of<UserProvider>(context).setUser(snapshot.data);
          //             return HomeScreen();
          //           }
          //           return Text('Error');
          //       }
          //     }),
          initialRoute: LettutorRoutes.start,
          onGenerateRoute: _registerRoutesWithParameters,
        ));
  }

  Map<String, WidgetBuilder> _registerRoutes() {
    return <String, WidgetBuilder>{
      LettutorRoutes.home: (context) => HomeScreen(),
      // LettutorRoutes.loading: LoadingScreen(),
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
        final courseDetail = routeSettings.arguments as Course;
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
