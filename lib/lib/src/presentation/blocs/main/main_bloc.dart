import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rich_chat_copilot/lib/src/core/utils/constants.dart';
import 'package:rich_chat_copilot/lib/src/domain/usecase/get_language_use_case.dart';
import 'package:rich_chat_copilot/lib/src/domain/usecase/get_theme_use_case.dart';
import 'package:rich_chat_copilot/lib/src/domain/usecase/set_language_use_case.dart';
import 'package:rich_chat_copilot/lib/src/domain/usecase/set_theme_use_case.dart';
import 'package:rich_chat_copilot/lib/src/presentation/blocs/main/main_state.dart';

class MainCubit extends Cubit<Locale> {
  final GetLanguageUseCase _getLanguageUseCase;
  final SetLanguageUseCase _setLanguageUseCase;

  MainCubit(
    this._getLanguageUseCase,
    this._setLanguageUseCase,
  ) : super(Locale(window.locale.languageCode)) {
    getLanguage();
  }

  void getLanguage() async {
    final language = _getLanguageUseCase();
    await _setLanguageUseCase(language);
    emit(Locale(language));
  }
}
