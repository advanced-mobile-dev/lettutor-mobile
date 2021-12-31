part of 'app_settings_bloc.dart';

abstract class AppSettingsEvent extends Equatable {
  const AppSettingsEvent();

  @override
  List<Object> get props => [];
}

class ThemeChangedEvent extends AppSettingsEvent {
  final bool isDarkTheme;
  ThemeChangedEvent({@required this.isDarkTheme});

  @override
  List<Object> get props => [isDarkTheme];
}

class LanguageChangedEvent extends AppSettingsEvent {
  final String locale;
  LanguageChangedEvent({@required this.locale});

  @override
  List<Object> get props => [locale];
}
