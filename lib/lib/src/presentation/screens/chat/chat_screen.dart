import 'package:flutter/material.dart';
import 'package:rich_chat_copilot/lib/src/core/base/widget/base_stateful_widget.dart';

class ChatScreen extends BaseStatefulWidget {
  final String userId;

  const ChatScreen({super.key, required this.userId});

  @override
  BaseState<ChatScreen> baseCreateState() => _ChatScreenState();
}

class _ChatScreenState extends BaseState<ChatScreen> {
  @override
  Widget baseBuild(BuildContext context) {
    return const Scaffold();
  }
}
