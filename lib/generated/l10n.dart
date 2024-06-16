// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Rich Chat Copilot`
  String get appTitle {
    return Intl.message(
      'Rich Chat Copilot',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'Rich Chat Copilot - Powered by OpenAI' key

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to the Copilot Chatbot. What would you like to chat about?`
  String get welcomeMessage {
    return Intl.message(
      'Welcome to the Copilot Chatbot. What would you like to chat about?',
      name: 'welcomeMessage',
      desc: '',
      args: [],
    );
  }

  /// `Chats`
  String get chats {
    return Intl.message(
      'Chats',
      name: 'chats',
      desc: '',
      args: [],
    );
  }

  /// `Groups`
  String get groups {
    return Intl.message(
      'Groups',
      name: 'groups',
      desc: '',
      args: [],
    );
  }

  /// `Globes`
  String get globes {
    return Intl.message(
      'Globes',
      name: 'globes',
      desc: '',
      args: [],
    );
  }

  /// `Rich Chat`
  String get richChat {
    return Intl.message(
      'Rich Chat',
      name: 'richChat',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Add your phone number, we'll send you a verification code`
  String get addYourPhoneNumberMessage {
    return Intl.message(
      'Add your phone number, we\'ll send you a verification code',
      name: 'addYourPhoneNumberMessage',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Verification`
  String get verification {
    return Intl.message(
      'Verification',
      name: 'verification',
      desc: '',
      args: [],
    );
  }

  /// `Enter the 6 digit code sent to your mobile number`
  String get enterThe6Digit {
    return Intl.message(
      'Enter the 6 digit code sent to your mobile number',
      name: 'enterThe6Digit',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code`
  String get resendCode {
    return Intl.message(
      'Resend Code',
      name: 'resendCode',
      desc: '',
      args: [],
    );
  }

  /// `Didn't recieve the code`
  String get didReceiveTheCode {
    return Intl.message(
      'Didn\'t recieve the code',
      name: 'didReceiveTheCode',
      desc: '',
      args: [],
    );
  }

  /// `User Information`
  String get userInformation {
    return Intl.message(
      'User Information',
      name: 'userInformation',
      desc: '',
      args: [],
    );
  }

  /// `Enter Name`
  String get enterName {
    return Intl.message(
      'Enter Name',
      name: 'enterName',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continues {
    return Intl.message(
      'Continue',
      name: 'continues',
      desc: '',
      args: [],
    );
  }

  /// `OTP SMS Not Valid`
  String get OTPSMSNotValid {
    return Intl.message(
      'OTP SMS Not Valid',
      name: 'OTPSMSNotValid',
      desc: '',
      args: [],
    );
  }

  /// `Sent to`
  String get sentTo {
    return Intl.message(
      'Sent to',
      name: 'sentTo',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Choose Image`
  String get chooseImage {
    return Intl.message(
      'Choose Image',
      name: 'chooseImage',
      desc: '',
      args: [],
    );
  }

  /// `Upload from Camera`
  String get uploadCamera {
    return Intl.message(
      'Upload from Camera',
      name: 'uploadCamera',
      desc: '',
      args: [],
    );
  }

  /// `Upload from Gallery`
  String get uploadGallery {
    return Intl.message(
      'Upload from Gallery',
      name: 'uploadGallery',
      desc: '',
      args: [],
    );
  }

  /// `Choose File`
  String get chooseFile {
    return Intl.message(
      'Choose File',
      name: 'chooseFile',
      desc: '',
      args: [],
    );
  }

  /// `Upload File`
  String get uploadFile {
    return Intl.message(
      'Upload File',
      name: 'uploadFile',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Enter Message`
  String get enterMessage {
    return Intl.message(
      'Enter Message',
      name: 'enterMessage',
      desc: '',
      args: [],
    );
  }

  /// `No Chats`
  String get noChats {
    return Intl.message(
      'No Chats',
      name: 'noChats',
      desc: '',
      args: [],
    );
  }

  /// `No Groups`
  String get noGroups {
    return Intl.message(
      'No Groups',
      name: 'noGroups',
      desc: '',
      args: [],
    );
  }

  /// `No Users`
  String get noUsers {
    return Intl.message(
      'No Users',
      name: 'noUsers',
      desc: '',
      args: [],
    );
  }

  /// `No Messages`
  String get noMessages {
    return Intl.message(
      'No Messages',
      name: 'noMessages',
      desc: '',
      args: [],
    );
  }

  /// `No Globes`
  String get noGlobes {
    return Intl.message(
      'No Globes',
      name: 'noGlobes',
      desc: '',
      args: [],
    );
  }

  /// `Upload Media`
  String get uploadMedia {
    return Intl.message(
      'Upload Media',
      name: 'uploadMedia',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `You should have camera permission`
  String get youShouldHaveCameraPermission {
    return Intl.message(
      'You should have camera permission',
      name: 'youShouldHaveCameraPermission',
      desc: '',
      args: [],
    );
  }

  /// `You should have gallery permission`
  String get youShouldHaveGalleryPermission {
    return Intl.message(
      'You should have gallery permission',
      name: 'youShouldHaveGalleryPermission',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
