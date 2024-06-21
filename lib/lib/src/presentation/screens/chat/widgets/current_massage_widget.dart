import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rich_chat_copilot/lib/src/config/theme/color_schemes.dart';
import 'package:rich_chat_copilot/lib/src/core/utils/massage_type.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/chat/massage.dart';
import 'package:rich_chat_copilot/lib/src/presentation/widgets/display_massage_type_widget.dart';
import 'package:swipe_to/swipe_to.dart';

class CurrentMassageWidget extends StatelessWidget {
  final Massage massage;
  final void Function() onRightSwipe;

  const CurrentMassageWidget({
    super.key,
    required this.massage,
    required this.onRightSwipe,
  });

  @override
  Widget build(BuildContext context) {
    final isReplying = massage.repliedTo.isNotEmpty;
    return SwipeTo(
      onRightSwipe: (details) {
        onRightSwipe();
      },
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
              minWidth: MediaQuery.of(context).size.width * 0.3),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadiusDirectional.only(
                   topStart: Radius.circular(20),
                  // topEnd: Radius.circular(15),
                  // bottomEnd: Radius.circular(15),
                  // bottomStart: Radius.circular(15),
                )),
            child: Stack(
              children: [
                Padding(
                  padding: massage.massageType == MassageType.text
                      ? const EdgeInsets.fromLTRB(10, 5, 20, 20)
                      : const EdgeInsets.fromLTRB(5, 5, 5, 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (isReplying) ...[
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                massage.repliedTo,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                              // (massage.massageType == MassageType.text)?
                              // Text(
                              //   massage.repliedMessage,
                              //   style: const TextStyle(
                              //       color: Colors.white, fontSize: 10)
                              // ):CachedNetworkImage(imageUrl: massage.repliedMessage),
                              DisplayMassageTypeWidget(
                                massageType: massage.massageType,
                                massage: massage.repliedMessage,
                                color: Colors.white,
                                maxLines: 1,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        )
                      ],
                      // (massage.massageType == MassageType.text)?
                      // Text(
                      //   massage.massage,
                      //   textAlign: TextAlign.end,
                      //   style: const TextStyle(color: Colors.white),
                      // ): CachedNetworkImage(imageUrl: massage.massage),
                      DisplayMassageTypeWidget(
                        massageType: massage.massageType,
                        massage: massage.massage,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                PositionedDirectional(
                  bottom: 4,
                  end: 10,
                  child: Row(
                    children: [
                      Text(
                        DateFormat("hh:mm a").format(massage.timeSent),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
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
