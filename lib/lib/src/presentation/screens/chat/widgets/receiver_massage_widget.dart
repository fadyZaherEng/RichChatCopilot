import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rich_chat_copilot/lib/src/config/theme/color_schemes.dart';
import 'package:rich_chat_copilot/lib/src/core/utils/massage_type.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/chat/massage.dart';
import 'package:rich_chat_copilot/lib/src/presentation/widgets/display_massage_type_widget.dart';
import 'package:swipe_to/swipe_to.dart';

class ReceiverMassageWidget extends StatelessWidget {
  final Massage massage;
  final void Function() onRightSwipe;

  const ReceiverMassageWidget({
    super.key,
    required this.massage,
    required this.onRightSwipe,
  });

  @override
  Widget build(BuildContext context) {
    final isReplying = massage.repliedTo.isNotEmpty;
    final senderName = massage.repliedTo == "You" ? "You" : massage.senderName;
    return SwipeTo(
      onRightSwipe: (details) {
        onRightSwipe();
      },
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
            minWidth: MediaQuery.of(context).size.width * 0.3,
          ),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: massage.massageType == MassageType.text
                      ? const EdgeInsets.fromLTRB(10, 5, 20, 20)
                      : const EdgeInsets.fromLTRB(5, 5, 5, 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isReplying) ...[
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                senderName,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                              // Text(
                              //   massage.repliedMessage,
                              //   style: const TextStyle(
                              //       color: Colors.black, fontSize: 10),
                              // ),
                              DisplayMassageTypeWidget(
                                massageType: massage.massageType,
                                massage: massage.repliedMessage,
                                color: Colors.black,
                                maxLines: 1,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        )
                      ],
                      // Text(
                      //   massage.massage,
                      //   textAlign: TextAlign.start,
                      //   style: const TextStyle(color: Colors.black),
                      // ),
                      DisplayMassageTypeWidget(
                        massageType: massage.massageType,
                        massage: massage.massage,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                PositionedDirectional(
                  bottom: 4,
                  start: 10,
                  child: Row(
                    children: [
                      Text(
                        DateFormat("hh:mm a").format(massage.timeSent),
                        style: const TextStyle(
                            color: ColorSchemes.black, fontSize: 10),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        massage.isSeen ? Icons.done_all : Icons.done,
                        color: massage.isSeen
                            ? Theme.of(context).colorScheme.primary
                            : Colors.white38,
                        size: 15,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
