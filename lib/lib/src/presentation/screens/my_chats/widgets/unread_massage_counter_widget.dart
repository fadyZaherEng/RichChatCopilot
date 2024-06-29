import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rich_chat_copilot/lib/src/presentation/blocs/chats/chats_bloc.dart';

class UnReadMassageCounterWidget extends StatelessWidget {
  final String uid;
  final String receiverId;
  final bool isGroup;

  const UnReadMassageCounterWidget({
    super.key,
    required this.uid,
    required this.receiverId,
    required this.isGroup,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: context.read<ChatsBloc>().getUnreadMassagesStream(
          userId: uid, receiverId: receiverId, isGroup: false),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const SizedBox();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        } else {
          final unreadMassages = snapshot.data ?? 0;
          return Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ]),
            child: Text(unreadMassages == 0 ? "" : "$unreadMassages",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                )),
          );
        }
      },
    );
  }
}
