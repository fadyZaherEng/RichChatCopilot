part of 'user_info_bloc.dart';

@immutable
sealed class UserInfoEvent {}
class SelectImageEvent extends UserInfoEvent {
  final File image;
  SelectImageEvent(this.image);
}
class ShowImageEvent extends UserInfoEvent {
  final File image;
  ShowImageEvent(this.image);
}