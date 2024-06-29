import 'package:flutter/material.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/chat/massage.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/chat/widgets/my_massage_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/chat/widgets/receiver_massage_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/chat/widgets/swipe_to_widget.dart';

class MassageWidget extends StatelessWidget {
  final Massage massage;
  final void Function() onRightSwipe;
  final bool isViewOnly;
  final bool isMe;
  final bool isGroupChat;

  const MassageWidget({
    super.key,
    required this.massage,
    required this.onRightSwipe,
    required this.isViewOnly,
    required this.isMe,
    required this.isGroupChat,
  });

  @override
  Widget build(BuildContext context) {
    final isReplying = massage.repliedTo.isNotEmpty;
    return isMe
        ? isViewOnly
            ? MyMassageWidget(
                massage: massage,
                isReplying: isReplying,
                isGroupChat: isGroupChat,
              )
            : SwipeToWidget(
                massage: massage,
                onRightSwipe: onRightSwipe,
                isViewOnly: isViewOnly,
                isMe: isMe,
                isGroupChat: isGroupChat,
              )
        : isViewOnly
            ? ReceiverMassageWidget(
                isReplying: isReplying,
                massage: massage,
                isGroupChat: isGroupChat,
              )
            : SwipeToWidget(
                isMe: isMe,
                massage: massage,
                isViewOnly: isViewOnly,
                onRightSwipe: onRightSwipe,
                isGroupChat: isGroupChat,
              );
  }
}
