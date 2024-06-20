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
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: ColorSchemes.iconBackGround,
          border: Border.all(color: ColorSchemes.primary),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                  massageReply!.isMe ? "You" : massageReply!.senderName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )),
                IconButton(
                    onPressed: () {
                      //TODO: set reply to null
                      setReplyMessageWithNull();
                    },
                    icon: const Icon(Icons.close)),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              massageReply!.massage,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ));
  }
}
