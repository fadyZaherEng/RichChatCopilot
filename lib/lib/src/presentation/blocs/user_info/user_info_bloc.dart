import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_info_event.dart';

part 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  UserInfoBloc() : super(UserInfoInitial()) {
    on<SelectImageEvent>(_onSelectImageEvent);
    on<ShowImageEvent>(_onShowImageEvent);
  }

  FutureOr<void> _onSelectImageEvent(
      SelectImageEvent event, Emitter<UserInfoState> emit) async {
    emit(SelectImageState(image: event.image));
  }

  FutureOr<void> _onShowImageEvent(
      ShowImageEvent event, Emitter<UserInfoState> emit) {
    emit(ShowImageState(image: event.image));
  }
}
