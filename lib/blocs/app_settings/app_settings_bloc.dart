import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lettutor_app/repositories/app_settings_repository.dart';

part 'app_settings_event.dart';
part 'app_settings_state.dart';

class AppSettingsBloc extends Bloc<AppSettingsEvent, AppSettingsState> {
  final AppSettingsRepository _appSettingsRepository;

  AppSettingsBloc(AppSettingsRepository appSettingsRepository)
      : _appSettingsRepository = appSettingsRepository,
        super(AppSettingsState(
            isDarkTheme: appSettingsRepository.isDarkMode,
            locale: appSettingsRepository.currentLanguageLocale)) {
    on<ThemeChangedEvent>(_onThemeChangedEvent);
    on<LanguageChangedEvent>(_onLanguageChangedEvent);
  }

  void _onThemeChangedEvent(
      ThemeChangedEvent event, Emitter<AppSettingsState> emit) {
    _appSettingsRepository.changeBrightnessToDark(event.isDarkTheme);
    emit(state.copyWith(isDarkTheme: event.isDarkTheme));
  }

  void _onLanguageChangedEvent(
      LanguageChangedEvent event, Emitter<AppSettingsState> emit) {
    _appSettingsRepository.changeLanguage(event.locale);
    emit(state.copyWith(locale: event.locale));
  }
}
