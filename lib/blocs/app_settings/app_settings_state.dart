part of 'app_settings_bloc.dart';

class AppSettingsState extends Equatable {
  final bool isDarkTheme;
  final String locale;
  AppSettingsState({@required this.isDarkTheme, @required this.locale});

  AppSettingsState copyWith({bool isDarkTheme, String locale}) {
    return AppSettingsState(
        isDarkTheme: isDarkTheme ?? this.isDarkTheme,
        locale: locale ?? this.locale);
  }

  @override
  List<Object> get props => [isDarkTheme, locale];
}
