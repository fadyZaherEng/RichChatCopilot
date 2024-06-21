import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/chat/massage_reply.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/chat/widgets/massage_reply_widget.dart';

class BottomChatWidget extends StatelessWidget {
  final String friendName;
  final String friendImage;
  final String friendId;
  final String groupId;
  final TextEditingController textEditingController;
  final Function() onSendPressed;
  final Function() onAttachPressed;
  final Function() onCameraPressed;
  final Function(String) onTextChange;
  final FocusNode focusNode;
  final MassageReply? massageReply;
  final Function() setReplyMessageWithNull;
  final bool isAttachedLoading;
  final bool isSendingLoading;

  const BottomChatWidget({
    super.key,
    required this.friendName,
    required this.friendImage,
    required this.friendId,
    required this.groupId,
    required this.textEditingController,
    required this.onSendPressed,
    required this.onAttachPressed,
    required this.onCameraPressed,
    required this.focusNode,
    required this.onTextChange,
    required this.massageReply,
    required this.setReplyMessageWithNull,
    required this.isAttachedLoading,
    required this.isSendingLoading,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            massageReply != null
                ? MassageReplyWidget(
                    massageReply: massageReply!,
                    setReplyMessageWithNull: setReplyMessageWithNull,
                  )
                : const SizedBox.shrink(),
            Container(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.41),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                // color: ColorSchemes.white,
                border: Border(
                  top: massageReply != null
                      ? BorderSide.none
                      : BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                  left:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                  right:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                  bottom:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                ),
                borderRadius: massageReply != null
                    ? null
                    : const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        // bottomLeft: Radius.circular(30),
                        // bottomRight: Radius.circular(30),
                      ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isAttachedLoading
                      ? Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: LoadingAnimationWidget.threeArchedCircle(
                            color: Theme.of(context).colorScheme.primary,
                            size: 35,
                          ),
                      )
                      : IconButton(
                          onPressed: onAttachPressed,
                          icon: const Icon(
                            Icons.attachment,
                            size: 20,
                          ),
                        ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: TextField(
                        controller: textEditingController,
                        focusNode: focusNode,
                        //how to expand with text increase problem
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        minLines: 1,
                        onChanged: (value) {
                          onTextChange(value);
                        },
                        decoration: const InputDecoration(
                          hintText: 'Type a message...',
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        ),
                      ),
                    ),
                  ),
                  isSendingLoading
                      ? Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: LoadingAnimationWidget.threeArchedCircle(
                            color: Theme.of(context).colorScheme.primary,
                            size: 25,
                          ),
                      )
                      : GestureDetector(
                          onTap: onSendPressed,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_upward,
                                color: Theme.of(context).cardColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
