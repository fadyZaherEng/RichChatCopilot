import 'package:flutter/material.dart';
import 'package:rich_chat_copilot/lib/src/config/theme/color_schemes.dart';

class BottomChatWidget extends StatelessWidget {
  final String friendName;
  final String friendImage;
  final String friendId;
  final String groupId;

  const BottomChatWidget({
    super.key,
    required this.friendName,
    required this.friendImage,
    required this.friendId,
    required this.groupId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorSchemes.iconBackGround,
        border: Border.all(color: ColorSchemes.primary),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.attachment,
              size: 20,
            ),
          ),
          const Expanded(
            child: TextField(
              //how to expand with text increase problem
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                //no border on textfield
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: ColorSchemes.primary,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_upward,
                  color: ColorSchemes.white,
                  size: 17,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
