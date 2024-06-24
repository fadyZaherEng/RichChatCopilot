import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rich_chat_copilot/lib/src/core/base/widget/base_stateful_widget.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/chat/massage.dart';

class StackedReactionsWidget extends StatefulWidget {
  final Massage massage;
  final double size;
  final void Function() onPressed;

  const StackedReactionsWidget({
    super.key,
    required this.massage,
    required this.size,
    required this.onPressed,
  });

  @override
  State<StackedReactionsWidget> createState() => _StackedReactionsWidgetState();
}

class _StackedReactionsWidgetState extends State<StackedReactionsWidget> {
  @override
  Widget build(BuildContext context) {
    final reactionShow = widget.massage.reactions.length > 5
        ? widget.massage.reactions.sublist(0, 5)
        : widget.massage.reactions;
    final remainingReactionsLength =
        widget.massage.reactions.length - reactionShow.length;
    return GestureDetector(
      onTap: widget.onPressed,
      child: Stack(
        children: _getAllReactions(reactionShow, remainingReactionsLength),
      ),
    );
  }

  List<Widget> _getAllReactions(
      List<String> reactions, int remainingReactionsLength) {
    return reactions
        .asMap()
        .map(
          (index, reaction) {
            return MapEntry(
              index,
              index == reactions.length - 1
                  ? Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: index * 18),
                          child: ClipOval(
                            child: Text(
                              reaction,
                              style: TextStyle(fontSize: widget.size),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        if (remainingReactionsLength > 0) ...[
                          Container(
                            margin: EdgeInsets.only(left: index * 22),
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              elevation: 5,
                              color: Colors.white,
                              clipBehavior: Clip.hardEdge,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 1),
                                child: ClipOval(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2.0, horizontal: 1),
                                    child: Text(
                                      '+$remainingReactionsLength',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]
                      ],
                    )
                  : Container(
                      margin: EdgeInsets.only(left: index * 18),
                      child: ClipOval(
                        child: Text(
                          reaction,
                          style: TextStyle(fontSize: widget.size),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
            );
          },
        )
        .values
        .toList();
  }
}
