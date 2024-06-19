part of 'chats_bloc.dart';

@immutable
sealed class ChatsEvent {}
class GetAllUsersEvent extends ChatsEvent {}
class GetCurrentUserEvent extends ChatsEvent {
  final String uid;
  GetCurrentUserEvent({required this.uid});
}
class SendTextMessageEvent extends ChatsEvent {
  final UserModel sender;
  final String receiverId;
  final String receiverName;
  final String receiverImage;
  final String message;
  final MassageType massageType;
  final String groupId;
  final MassageReply? repliedMessage;

  SendTextMessageEvent({
    required this.sender,
    required this.receiverId,
    required this.receiverName,
    required this.receiverImage,
    required this.message,
    required this.massageType,
    required this.groupId,
     this.repliedMessage,
  });
}

