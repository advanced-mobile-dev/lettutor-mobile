import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/booking_history/booking_history_bloc.dart';
import 'package:lettutor_app/blocs/bottom_nav/bottom_nav_bloc.dart';
import 'package:lettutor_app/blocs/courses/courses_bloc.dart';
import 'package:lettutor_app/blocs/favorite_list/favorite_list_bloc.dart';
import 'package:lettutor_app/blocs/favorite_tutor/favorite_tutor_bloc.dart';
import 'package:lettutor_app/blocs/tutor_profile/tutor_profile_bloc.dart';
import 'package:lettutor_app/blocs/tutor_report/tutor_report_bloc.dart';
import 'package:lettutor_app/blocs/tutor_schedule/tutor_schedule_bloc.dart';
import 'package:lettutor_app/repositories/course_repository.dart';
import 'package:lettutor_app/repositories/payment_repository.dart';
import 'package:lettutor_app/repositories/user_repository.dart';
import 'package:lettutor_app/screens/favorite_list/favorite_list_screen.dart';
import 'package:lettutor_app/screens/topic/topic_screen.dart';
import 'package:lettutor_app/screens/tutor_report/tutor_report_screen.dart';
import 'blocs/lesson_time_bloc/lesson_time_bloc.dart';
import 'blocs/meeting/meeting_bloc.dart';
import 'blocs/reservation/reservation_bloc.dart';
import 'blocs/student_booking/student_booking_bloc.dart';
import 'blocs/tutors/tutors_bloc.dart';
import 'blocs/user_profile/user_profile_bloc.dart';
import 'models/booking/booking.dart';
import 'models/course/course.dart';
import 'models/course/topic.dart';
import 'models/tutor/tutor.dart';
import 'repositories/tutor_repository.dart';
import 'screens/change_password/change_password_screen.dart';
import 'screens/course_detail/course_detail_screen.dart';
import 'screens/dash_board/dash_board.dart';
import 'screens/booking_history.dart/history_screen.dart';
import 'screens/meeting/meeting_screen.dart';
import 'screens/reservation/reservation_screen.dart';
import 'screens/forget_password/forget_password_screen.dart';
import 'screens/language_setting/language_setting_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';
import 'screens/splash_screen/splash_screen.dart';
import 'screens/start_screen/start_screen.dart';
import 'screens/tutor_profile/tutor_profile.dart';
import 'screens/tutor_schedule/tutor_schedule_screen.dart';
import 'screens/user_profile/user_profile.dart';

class LettutorRoutes {
  static const splash = '/';
  static const home = 'home';
  static const loading = 'loading';
  static const start = 'start';
  static const signUp = 'sign-up';
  static const signIn = 'sign-in';
  static const forgetPassword = 'forget-password';
  static const history = 'history';
  static const tutorProfile = 'tutor-profile';
  static const tutorSchedule = 'tutor-calendar';
  static const booking = 'booking';
  static const courseDetail = 'course-detail';
  static const userProfile = 'user-profile';
  static const changePassword = 'change-password';
  static const languageSetting = 'language-setting';
  static const videoConference = 'video-conference';
  static const tutorReport = 'tutor-report';
  static const favoriteTutors = 'favorite-tutors';
  static const meeting = 'meeting';
  static const topic = 'topic';
}

Map<String, WidgetBuilder> registerRoutes() {
  return <String, WidgetBuilder>{
    LettutorRoutes.splash: (context) => SplashScreen(),
    LettutorRoutes.home: (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<BottomNavBloc>(
            create: (_) => BottomNavBloc(),
          ),
          BlocProvider<TutorsBloc>(
            create: (_) =>
                TutorsBloc(tutorRepository: context.read<TutorRepository>())
                  ..add(TutorsFetchEvent()),
          ),
          BlocProvider<StudentBookingBloc>(
            create: (_) => StudentBookingBloc(
                userRepository: RepositoryProvider.of<UserRepository>(context)),
          ),
          BlocProvider<CoursesBloc>(
            create: (_) =>
                CoursesBloc(courseRepository: context.read<CourseRepository>())
                  ..add(CoursesFetchEvent()),
          ),
          BlocProvider<LessonTimeBloc>(
            create: (_) => LessonTimeBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context),
            )..add(LessonTimeFetchEvent()),
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
    LettutorRoutes.history: (context) {
      return BlocProvider(
          create: (context) =>
              BookingHistoryBloc(userRepository: context.read<UserRepository>())
                ..add(BookingHistoryFetchDataEvent()),
          child: HistoryScreen());
    },
    LettutorRoutes.favoriteTutors: (context) {
      return BlocProvider(
          create: (context) =>
              FavoriteListBloc(userRepository: context.read<UserRepository>())
                ..add(FavoriteListFetchEvent()),
          child: FavoriteTutorsScreen());
    },
    LettutorRoutes.start: (context) => StartScreen(),
    LettutorRoutes.signUp: (context) => SignUpScreen(),
    LettutorRoutes.signIn: (context) => LoginScreen(),
    LettutorRoutes.changePassword: (context) => ChangePasswordScreen(),
    LettutorRoutes.languageSetting: (context) => LanguageSettingScreen(),
    LettutorRoutes.forgetPassword: (context) => ForgetPasswordScreen(),
  };
}

Route<dynamic> registerRoutesWithParameters(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LettutorRoutes.booking:
      final args = routeSettings.arguments as ReservationScreenArguments;
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
              create: (context) => ReservationBloc(
                    tutor: args.tutor,
                    scheduleDetail: args.scheduleDetail,
                    userRepository:
                        RepositoryProvider.of<UserRepository>(context),
                    paymentRepository:
                        RepositoryProvider.of<PaymentRepository>(context),
                  ),
              child: ReservationScreen()));
      break;

    case LettutorRoutes.courseDetail:
      final course = routeSettings.arguments as Course;
      return MaterialPageRoute(
          builder: (context) => CourseDetailScreen(course: course));

      break;

    case LettutorRoutes.tutorSchedule:
      final tutor = routeSettings.arguments as Tutor;
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
              create: (context) => TutorScheduleBloc(
                  tutor: tutor,
                  tutorRepository: context.read<TutorRepository>())
                ..add(TutorScheduleFetchEvent()),
              child: TutorScheduleScreen(
                tutor: tutor,
              )));

      break;

    case LettutorRoutes.tutorProfile:
      final String tutorId = routeSettings.arguments;
      return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(providers: [
                BlocProvider(
                  create: (_) => TutorProfileBloc(
                      tutorId: tutorId,
                      tutorRepository: context.read<TutorRepository>())
                    ..add(TutorProfileFetchEvent()),
                ),
                BlocProvider(
                  create: (_) => FavoriteTutorBloc(
                      userRepository: context.read<UserRepository>()),
                )
              ], child: TutorProfile()));
      break;

    case LettutorRoutes.tutorReport:
      final tutor = routeSettings.arguments as Tutor;
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
            create: (_) => TutorReportBloc(
                tutor: tutor, userRepository: context.read<UserRepository>()),
            child: TutorReportScreen()),
      );
      break;

    case LettutorRoutes.meeting:
      final booking = routeSettings.arguments as Booking;
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
            create: (_) => MeetingBloc(
                booking: booking,
                userRepository: context.read<UserRepository>()),
            child: MeetingScreen()),
      );

    case LettutorRoutes.topic:
      final topic = routeSettings.arguments as Topic;
      return MaterialPageRoute(
        builder: (context) => TopicScreen(topic),
      );
  }

  return null;
}
