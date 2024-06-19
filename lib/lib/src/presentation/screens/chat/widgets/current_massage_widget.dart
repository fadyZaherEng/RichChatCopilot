import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/chat/massage.dart';

class CurrentMassageWidget extends StatelessWidget {
  final Massage massage;

  const CurrentMassageWidget({super.key, required this.massage});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
          minWidth: MediaQuery.of(context).size.width * 0.3,
        ),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadiusDirectional.only(
              // topStart: Radius.circular(15),
              topEnd: Radius.circular(15),
              // bottomEnd: Radius.circular(15),
              // bottomStart: Radius.circular(10),
            )
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: 10, end: 30, top: 5, bottom: 20),
                child: Text(
                  massage.massage,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              PositionedDirectional(
                bottom: 4,
                start: 10,
                child: Row(
                  children: [
                    Text(
                      DateFormat("hh:mm a").format(massage.timeSent),
                      style: const TextStyle(color: Colors.white, fontSize: 10),
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
