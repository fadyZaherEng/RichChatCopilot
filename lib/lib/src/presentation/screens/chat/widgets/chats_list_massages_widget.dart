import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:rich_chat_copilot/generated/l10n.dart';
import 'package:rich_chat_copilot/lib/src/config/theme/color_schemes.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/chat/massage.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/chat/massage_reply.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/login/user.dart';
import 'package:rich_chat_copilot/lib/src/presentation/blocs/chats/chats_bloc.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/chat/widgets/current_massage_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/chat/widgets/receiver_massage_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/widgets/build_date_widget.dart';

class ChatsListMassagesWidget extends StatefulWidget {
  final Stream<List<Massage>> massagesStream;
  final ScrollController massagesScrollController;
  final UserModel currentUser;
  final String friendId;
  final void Function(MassageReply massageReply) onRightSwipe;

  const ChatsListMassagesWidget({
    super.key,
    required this.massagesStream,
    required this.massagesScrollController,
    required this.currentUser,
    required this.onRightSwipe,
    required this.friendId,
  });

  @override
  State<ChatsListMassagesWidget> createState() =>
      _ChatsListMassagesWidgetState();
}

class _ChatsListMassagesWidgetState extends State<ChatsListMassagesWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragDown: (_) {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<List<Massage>>(
          stream: widget.massagesStream,
          builder: (context, snapshot) {
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return const CircleLoadingWidget();
            // }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  S.of(context)
                      .somethingWentWrong,
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ColorSchemes.gray,
                  ),
                ),
              );
            }
            if (!snapshot.hasData ||
                snapshot.data!.isEmpty ||
                snapshot.data == null) {
              return Center(
                child: Text(
                  S.of(context)
                      .startConversation,
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: ColorSchemes.black,
                  ),
                ),
              );
            }
            if (snapshot.hasData) {
              //add list view scroll to bottom
              WidgetsBinding.instance.addPostFrameCallback((_) {
                widget.massagesScrollController.animateTo(
                  widget.massagesScrollController.position.minScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              });
              final massages = snapshot.data!;
              return GroupedListView<dynamic, DateTime>(
                 reverse: true,
                elements: massages,
                controller: widget.massagesScrollController,
                groupBy: (massage) =>
                    DateTime(massage.timeSent.year,
                        massage.timeSent.month, massage.timeSent.day),
                groupHeaderBuilder: (massage) =>
                    buildDateWidget(
                      context: context,
                      dateTime: massage.timeSent,
                    ),
                useStickyGroupSeparators: true,
                floatingHeader: true,
                order: GroupedListOrder.DESC,
                itemBuilder: (context, massage) {
                  //set massage as seen in fireStore
                  if (massage.isSeen == false &&
                      massage.senderId != widget.currentUser.uId) {
                    BlocProvider.of<ChatsBloc>(context).setMassageAsSeen(
                        senderId: widget.currentUser.uId,
                        receiverId: widget.friendId,
                        massageId: massage.messageId,
                        groupId: "");
                  }
                  bool isMe = massage.senderId == widget.currentUser.uId;
                  return isMe
                      ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CurrentMassageWidget(
                      massage: massage,
                      onRightSwipe: () {
                        final massageReply = MassageReply(
                          massage: massage.massage,
                          senderName: massage.senderName,
                          senderId: massage.senderId,
                          senderImage: massage.senderImage,
                          massageType: massage.massageType,
                          isMe: isMe,
                        );
                        // _bloc.setMassageReply(massageReply);
                        widget.onRightSwipe(massageReply);
                      },
                    ),
                  )
                      : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ReceiverMassageWidget(
                      massage: massage,
                      onRightSwipe: () {
                        final massageReply = MassageReply(
                          massage: massage.massage,
                          senderName: massage.senderName,
                          senderId: massage.senderId,
                          senderImage: massage.senderImage,
                          massageType: massage.massageType,
                          isMe: isMe,
                        );
                        // _bloc.setMassageReply(massageReply);
                        widget.onRightSwipe(massageReply);
                      },
                    ),
                  );
                },
                itemComparator: (massage1, massage2) =>
                    massage1.timeSent.compareTo(massage2.timeSent),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
