import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rich_chat_copilot/lib/src/config/routes/routes_manager.dart';
import 'package:rich_chat_copilot/lib/src/config/theme/color_schemes.dart';
import 'package:rich_chat_copilot/lib/src/core/resources/image_paths.dart';
import 'package:rich_chat_copilot/lib/src/presentation/widgets/custom_snack_bar_widget.dart';

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
    print(event.phoneNumber);
    PhoneAuthCredential? credential;
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: event.phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        credential = credential;
        await firebaseAuth.signInWithCredential(credential);
        emit(LogInSuccessState(uId: firebaseAuth.currentUser!.uid, MSG: "success"));
        },
      verificationFailed: (FirebaseAuthException e) {
        CustomSnackBarWidget.show(
          context: event.context,
          message: e.message.toString(),
          path: ImagePaths.icCancel,
          backgroundColor: ColorSchemes.red,
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        print(verificationId);
        // emit(LogInCodeSentState(verificationId: verificationId));
        print("codeSent FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF $resendToken $verificationId");
        Navigator.pushNamed(event.context, Routes.otpScreen,
            arguments: {"verificationCode": verificationId,"phoneNumber": event.phoneNumber});
      },
      codeAutoRetrievalTimeout: (String verificationId) {
      },
      timeout: const Duration(seconds: 60),
    );
    await Future.delayed( const Duration(seconds: 3));
    emit(LogInFinishState());

    // if (credential != null) {
    //   final UserCredential userCredential =
    //       await firebaseAuth.signInWithCredential(credential);
    //   emit(LogInSuccessState(uId: userCredential.user!.uid, MSG: "success"));
    // }
  }

  FutureOr<void> _onLogInOnChangeCountryEvent(
      LogInOnChangeCountryEvent event, Emitter<LogInState> emit) {
    emit(LogInOnChangeCountryState(event.country));
  }
}
