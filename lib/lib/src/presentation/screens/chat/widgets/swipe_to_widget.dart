import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rich_chat_copilot/lib/src/core/utils/massage_type.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/chat/massage.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/chat/widgets/display_massage_type_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/chat/widgets/my_massage_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/chat/widgets/receiver_massage_widget.dart';
import 'package:swipe_to/swipe_to.dart';

class SwipeToWidget extends StatelessWidget {
  final Massage massage;
  final void Function() onRightSwipe;
  final bool isViewOnly;
  final bool isMe;

  const SwipeToWidget({
    super.key,
    required this.massage,
    required this.onRightSwipe,
    required this.isViewOnly,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final isReplying = massage.repliedTo.isNotEmpty;
    return SwipeTo(
      onRightSwipe: (details) {
        onRightSwipe();
      },
      child: isMe
          ? MyMassageWidget(
              massage: massage,
              isReplying: isReplying,
            )
          : ReceiverMassageWidget(
              isReplying: isReplying,
              massage: massage,
            ),
    );
  }
}
