import 'package:flutter/material.dart';
import 'package:rich_chat_copilot/lib/src/core/base/widget/base_stateful_widget.dart';

class ChatScreen extends BaseStatefulWidget {
  final String friendId;
  final String friendName;
  final String friendImage;
  final String groupId;

  const ChatScreen({
    super.key,
    required this.friendId,
    required this.friendName,
    required this.friendImage,
    required this.groupId,
  });

  @override
  BaseState<ChatScreen> baseCreateState() => _ChatScreenState();
}

class _ChatScreenState extends BaseState<ChatScreen> {
  @override
  Widget baseBuild(BuildContext context) {
    return const Scaffold();
  }
}
