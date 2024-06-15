import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:country_picker/country_picker.dart';
import 'package:meta/meta.dart';

part 'log_in_event.dart';

part 'log_in_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  LogInBloc() : super(LogInInitial()) {
    on<LogInOnChangePhoneNumberEvent>(_onLogInOnChangePhoneNumberEvent);
    on<LogInOnChangeCountryEvent>(_onLogInOnChangeCountryEvent);
  }

  FutureOr<void> _onLogInOnChangePhoneNumberEvent(
      LogInOnChangePhoneNumberEvent event, Emitter<LogInState> emit) {
    emit(LogInOnChangePhoneNumberState(event.value));
  }
}

FutureOr<void> _onLogInOnChangeCountryEvent(
    LogInOnChangeCountryEvent event, Emitter<LogInState> emit) {
  emit(LogInOnChangeCountryState(event.country));
}
