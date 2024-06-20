import 'package:flutter/material.dart';
import 'package:rich_chat_copilot/lib/src/config/theme/color_schemes.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/chat/massage_reply.dart';

class MassageReplyWidget extends StatelessWidget {
  final MassageReply? massageReply;
  final void Function() setReplyMessageWithNull;

  const MassageReplyWidget({
    super.key,
    required this.massageReply,
    required this.setReplyMessageWithNull,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          top: BorderSide(color: Theme.of(context).colorScheme.primary),
          left: BorderSide(color: Theme.of(context).colorScheme.primary),
          right: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: ListTile(
        title: Text(
          massageReply!.isMe ? "You" : massageReply!.senderName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          massageReply!.massage,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          onPressed: () {
            //TODO: set reply to null
            setReplyMessageWithNull();
          },
          icon: const Icon(Icons.close),
        ),
      ),
    );
  }
}
