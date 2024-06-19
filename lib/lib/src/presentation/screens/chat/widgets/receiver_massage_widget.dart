import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rich_chat_copilot/lib/src/config/theme/color_schemes.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/chat/massage.dart';

class ReceiverMassageWidget extends StatelessWidget {
  final Massage massage;

  const ReceiverMassageWidget({super.key, required this.massage});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
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
                padding: const EdgeInsetsDirectional.only(
                    start: 10, end: 30, top: 5, bottom: 20),
                child: Text(
                  massage.massage,
                  style: const TextStyle(color: ColorSchemes.black),
                ),
              ),
              PositionedDirectional(
                bottom: 4,
                start: 10,
                child: Row(
                  children: [
                    Text(
                      DateFormat("hh:mm a").format(massage.timeSent),
                      style: const TextStyle(color: ColorSchemes.black, fontSize: 10),
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
    );
  }
}
