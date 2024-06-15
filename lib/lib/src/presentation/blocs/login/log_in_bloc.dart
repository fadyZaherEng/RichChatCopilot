import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';

part 'log_in_event.dart';

part 'log_in_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  LogInBloc() : super(LogInInitial()) {
    on<LogInOnChangePhoneNumberEvent>(_onLogInOnChangePhoneNumberEvent);
    on<LogInOnChangeCountryEvent>(_onLogInOnChangeCountryEvent);
    on<LogInOnLogInEvent>(_onLogInOnLogInEvent);
  }

  FutureOr<void> _onLogInOnChangePhoneNumberEvent(
      LogInOnChangePhoneNumberEvent event, Emitter<LogInState> emit) {
    emit(LogInOnChangePhoneNumberState(event.value));
  }

  FutureOr<void> _onLogInOnLogInEvent(
      LogInOnLogInEvent event, Emitter<LogInState> emit) async {
    emit(LogInLoadingState());
    await firebaseAuth
        .verifyPhoneNumber(
          verificationCompleted: (PhoneAuthCredential credential) async {
            await firebaseAuth.signInWithCredential(credential).then((value) {
              emit(LogInSuccessState(uId: value.user!.uid ?? "",MSG: "Logged Successfully"));
            });
          },
          verificationFailed: (FirebaseAuthException e) {
            emit(LogInErrorState(message: e.message.toString()));
          },
          codeSent: (String verificationId, int? resendToken) async {
            emit(LogInCodeSentState(verificationId: verificationId));
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            emit(LogInErrorState(message: 'Code auto retrieval timeout'));
          },
          phoneNumber: event.phoneNumber,
          timeout: const Duration(seconds: 60),
        )
        .then((value) {})
        .catchError((error) {
      emit(LogInErrorState(message: error.toString()));
    });
  }

  FutureOr<void> _onLogInOnChangeCountryEvent(
      LogInOnChangeCountryEvent event, Emitter<LogInState> emit) {
    emit(LogInOnChangeCountryState(event.country));
  }
}
