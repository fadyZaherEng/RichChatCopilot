import 'dart:ui';

abstract class MainState {}

class MainInitial extends MainState {}

class GetLocalAndThemeState extends MainState {
  final Locale locale;
  final String theme;
  GetLocalAndThemeState({required this.locale, required this.theme});
}