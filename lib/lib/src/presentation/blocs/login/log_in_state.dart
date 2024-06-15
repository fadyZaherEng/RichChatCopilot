part of 'log_in_bloc.dart';

@immutable
sealed class LogInState {}

final class LogInInitial extends LogInState {}
class LogInOnChangePhoneNumberState extends LogInState{
  final String value;
  LogInOnChangePhoneNumberState(this.value);
}
class LogInOnChangeCountryState extends LogInState{
  final Country country;
  LogInOnChangeCountryState(this.country);
}
