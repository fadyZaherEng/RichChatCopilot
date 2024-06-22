import 'package:flutter/material.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/chat/massage.dart';

class ReactionsDialogWidget extends StatefulWidget {
  final String uId;
  final Massage message;
  final void Function(String) onEmojiSelected;
  final void Function(String) onContextMenuSelected;

  const ReactionsDialogWidget({
    super.key,
    required this.uId,
    required this.message,
    required this.onEmojiSelected,
    required this.onContextMenuSelected,
  });

  @override
  State<ReactionsDialogWidget> createState() => _ReactionsDialogWidgetState();
}

class _ReactionsDialogWidgetState extends State<ReactionsDialogWidget> {
  //list of default reactions
  final List<String> _reactions = [
    "👍",
    "❤️",
    "😂",
    "😮",
    "😢",
    "😡",
    "➕",
  ];
  final List<String> _contextMenu = ["Replay", "Copy", "Delete"];

  @override
  Widget build(BuildContext context) {
    final isMyMessage = widget.uId == widget.message.senderId;
    return Align(
      alignment: Alignment.centerRight,
      child: IntrinsicWidth(
        child: Wrap(
          children: [
            Column(
               mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: isMyMessage
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey[400],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (var reaction in _reactions)
                            InkWell(
                              onTap: () {
                                widget.onEmojiSelected(reaction);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  reaction,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: isMyMessage
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey[400],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.message.massage,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (var contextMenu in _contextMenu)
                            InkWell(
                              onTap: () {
                                widget.onEmojiSelected(contextMenu);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      contextMenu,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Icon(
                                      contextMenu == "Replay"
                                          ? Icons.reply
                                          : contextMenu == "Copy"
                                              ? Icons.copy
                                              : Icons.delete,
                                    )
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
