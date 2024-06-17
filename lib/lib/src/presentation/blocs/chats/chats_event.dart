part of 'chats_bloc.dart';

@immutable
sealed class ChatsEvent {}
class GetAllUsersEvent extends ChatsEvent {}
class GetCurrentUserEvent extends ChatsEvent {
  final String uid;
  GetCurrentUserEvent({required this.uid});
}
