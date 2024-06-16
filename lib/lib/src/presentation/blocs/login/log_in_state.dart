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
class LogInErrorState extends LogInState{
  final String message;
  LogInErrorState({required this.message});
}
class LogInLoadingState extends LogInState{}
class LogInSuccessState extends LogInState{
  final String uId;
  final String MSG;
  LogInSuccessState({required this.uId,required this.MSG});
}
class LogInCodeSentState extends LogInState{
  final String verificationId;
  LogInCodeSentState({required this.verificationId});
}
class LogInFinishState extends LogInState{}