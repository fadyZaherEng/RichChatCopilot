import 'package:flutter/material.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/chat/massage.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/chat/widgets/reactions_dialog_widget.dart';

void showReactionsDialog({
  required BuildContext context,
  required Massage massage,
  required String uId,
  required void Function(String,Massage) onContextMenuSelected,
  required void Function(String) onEmojiSelected,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) => Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: ReactionsDialogWidget(
          message: massage,
          uId: uId,
          onContextMenuSelected: (contextMenu,massage) {
            onContextMenuSelected(contextMenu,massage);
          },
          onEmojiSelected: (emoji) {
            onEmojiSelected(emoji);
          },
        ),
      ),
    ),
  );
}
