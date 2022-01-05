import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lettutor_app/blocs/app_settings/app_settings_bloc.dart';
import 'package:lettutor_app/blocs/tutor_booking/tutor_booking_bloc.dart';
import 'package:lettutor_app/blocs/tutor_schedule/tutor_schedule_bloc.dart';
import 'package:lettutor_app/config/config.dart';
import 'package:lettutor_app/repositories/app_settings_repo.dart';
import 'package:lettutor_app/repositories/payment_repo.dart';
import 'package:lettutor_app/repositories/user_repository.dart';
import 'blocs/authentication/authentication_bloc.dart';
import 'blocs/tutors/tutors_bloc.dart';
import 'blocs/user_profile/user_profile_bloc.dart';
import 'config/colors.dart';
import 'config/languages.dart';
import 'config/routes.dart';
import 'config/theme.dart';
import 'data/repository.dart';
import 'models/course.dart';
import 'models/tutor/tutor.dart';
import 'repositories/authentication_repo.dart';
import 'repositories/tutor_repo.dart';
import 'screens/booking/booking_screen.dart';
import 'screens/change_password/change_password_screen.dart';
import 'screens/course_detail/course_detail_screen.dart';
import 'screens/dash_board/dash_board.dart';
import 'screens/dash_board/tabs/home/history_screen.dart';
import 'screens/dash_board/tabs/home/video_conference.dart';
import 'screens/forget_password/forget_password_screen.dart';
import 'screens/language_setting/language_setting_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';
import 'screens/splash_screen/splash_screen.dart';
import 'screens/start_screen/start_screen.dart';
import 'screens/tutor_calendar/tutor_schedule_screen.dart';
import 'screens/tutor_profile/tutor_profile.dart';
import 'screens/user_profile/user_profile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        child: MyApp(),
      ),
    )),
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
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
        routes: _registerRoutes(),
        // initialRoute: userProvider.loggedInStatus == AuthStatus.NotLoggedIn
        //     ? LettutorRoutes.start
        //     : LettutorRoutes.home,
        onGenerateRoute: _registerRoutesWithParameters,
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

  Map<String, WidgetBuilder> _registerRoutes() {
    return <String, WidgetBuilder>{
      LettutorRoutes.splash: (context) => SplashScreen(),
      LettutorRoutes.home: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<TutorsBloc>(
              create: (_) => TutorsBloc(),
            ),
          ],
          child: DashBoard(),
        );
      },
      LettutorRoutes.userProfile: (context) {
        final UserRepository _userRepo = context.read<UserRepository>();
        return BlocProvider(
            create: (context) => UserProfileBloc(_userRepo),
            child: UserProfileScreen());
      },
      LettutorRoutes.start: (context) => StartScreen(),
      LettutorRoutes.signUp: (context) => SignUpScreen(),
      LettutorRoutes.signIn: (context) => LoginScreen(),
      LettutorRoutes.history: (context) => HistoryScreen(),
      LettutorRoutes.tutorProfile: (context) => TutorProfile(),
      LettutorRoutes.changePassword: (context) => ChangePasswordScreen(),
      LettutorRoutes.languageSetting: (context) => LanguageSettingScreen(),
      LettutorRoutes.forgetPassword: (context) => ForgetPasswordScreen(),
      LettutorRoutes.videoConference: (context) => VideoConference(),
    };
  }

  Route<dynamic> _registerRoutesWithParameters(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case LettutorRoutes.booking:
        final args = routeSettings.arguments as BookingScreenArguments;
        print(args.tutor);
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (context) => TutorBookingBloc(
                      tutor: args.tutor,
                      scheduleDetail: args.scheduleDetail,
                      userRepository:
                          RepositoryProvider.of<UserRepository>(context),
                      paymentRepository:
                          RepositoryProvider.of<PaymentRepository>(context),
                    ),
                child: BookingScreen()));
        //   (context) => BookingScreen(
        //       tutor: args.tutor, scheduleDetail: args.scheduleDetail),
        // );

        break;

      case LettutorRoutes.courseDetail:
        final courseDetail = routeSettings.arguments as CourseTmp;
        return MaterialPageRoute(
            builder: (context) => CourseDetailScreen(course: courseDetail));

        break;

      case LettutorRoutes.tutorSchedule:
        final tutor = routeSettings.arguments as Tutor;
        print(tutor);
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (context) =>
                    TutorScheduleBloc(tutor)..add(FetchTutorSchedulesEvent()),
                child: TutorScheduleScreen(
                  tutor: tutor,
                )));

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

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) print(change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}
