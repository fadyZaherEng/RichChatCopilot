import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rich_chat_copilot/lib/src/config/theme/color_schemes.dart';
import 'package:rich_chat_copilot/lib/src/core/base/widget/base_stateful_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/chat/widgets/bottom_chat_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/chat/widgets/chat_app_bar_widget.dart';

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
  bool _isGroupChat = false;

  @override
  void initState() {
    super.initState();
    _isGroupChat = widget.groupId.isNotEmpty;
  }

  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Padding(
          padding: const EdgeInsetsDirectional.only(
              start: 5, end: 10, top: 18, bottom: 0),
          child: ChatAppBarWidget(friendId: widget.friendId),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: 50,
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemBuilder: (context, index) {
                return const ListTile(
                  title: Text('title'),
                  subtitle: Text('subtitle'),
                );
              },
            ),
          ),
          const SizedBox(height: 15,),
          BottomChatWidget(
            friendId: widget.friendId,
            friendName: widget.friendName,
            friendImage: widget.friendImage,
            groupId: widget.groupId,
          ),
        ],
      ),
    );
  }
}
