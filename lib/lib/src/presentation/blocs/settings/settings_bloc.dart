import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rich_chat_copilot/lib/src/core/utils/constants.dart';
import 'package:rich_chat_copilot/lib/src/di/data_layer_injector.dart';
import 'package:rich_chat_copilot/lib/src/domain/usecase/set_theme_use_case.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SetThemeUseCase _setThemeUseCase;
  SettingsBloc(
    this._setThemeUseCase,
      ) : super(SettingsInitial()) {
    on<ChangeLanguageEvent>(_onChangeLanguageEvent);
    on<ChangeThemeEvent>(_onChangeThemeEvent);
  }

  FutureOr<void> _onChangeLanguageEvent(
      ChangeLanguageEvent event, Emitter<SettingsState> emit)async {

  }

  FutureOr<void> _onChangeThemeEvent(
      ChangeThemeEvent event, Emitter<SettingsState> emit)async {
    await _setThemeUseCase(event.isDarkTheme ? Constants.dark : Constants.light);
    emit(ChangeThemeSuccess());
  }
}
