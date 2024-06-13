import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rich_chat_copilot/lib/src/core/utils/constants.dart';
import 'package:rich_chat_copilot/lib/src/domain/usecase/get_language_use_case.dart';
import 'package:rich_chat_copilot/lib/src/domain/usecase/get_theme_use_case.dart';
import 'package:rich_chat_copilot/lib/src/domain/usecase/set_language_use_case.dart';
import 'package:rich_chat_copilot/lib/src/domain/usecase/set_theme_use_case.dart';
import 'package:rich_chat_copilot/lib/src/presentation/blocs/main/main_state.dart';

class MainCubit extends Cubit<MainState> {
  final GetLanguageUseCase _getLanguageUseCase;
  final SetLanguageUseCase _setLanguageUseCase;
  final SetThemeUseCase _setThemeUseCase;
  final GetThemeUseCase _getThemeUseCase;

  MainCubit(
    this._getLanguageUseCase,
    this._setLanguageUseCase,
    this._setThemeUseCase,
    this._getThemeUseCase,
  ) : super(MainInitial()) {
    getLanguageAndTheme();
  }

  void getLanguageAndTheme() async {
    final language = _getLanguageUseCase();
    await _setLanguageUseCase(language);
    final theme = _getThemeUseCase();
    await _setThemeUseCase(theme ? Constants.dark : Constants.light);
    emit(GetLocalAndThemeState(
        locale: Locale(language),
        theme: theme ? Constants.dark : Constants.light));
  }
}
