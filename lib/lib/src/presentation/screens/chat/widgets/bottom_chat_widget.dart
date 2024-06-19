import 'package:flutter/material.dart';
import 'package:rich_chat_copilot/lib/src/config/theme/color_schemes.dart';

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
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.41),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: ColorSchemes.iconBackGround,
          border: Border.all(color: ColorSchemes.primary),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
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
            GestureDetector(
              onTap: onSendPressed,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: ColorSchemes.primary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child:  Center(
                  child: Icon(
                    Icons.arrow_upward,
                    color: ColorSchemes.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
