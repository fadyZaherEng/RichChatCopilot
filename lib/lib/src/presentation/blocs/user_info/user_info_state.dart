part of 'user_info_bloc.dart';

@immutable
sealed class UserInfoState {}

final class UserInfoInitial extends UserInfoState {}
final class SelectImageState extends UserInfoState {
  final File image;
  SelectImageState({required this.image});
}
final class ShowImageState extends UserInfoState {
  final File image;
  ShowImageState({required this.image});
}
