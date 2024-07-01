import 'package:flutter/material.dart';
import 'package:rich_chat_copilot/lib/src/core/utils/show_animated_dialog.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/create_group/widgets/setting_list_tile_widget.dart';

class ExitWidget extends StatelessWidget {
  const ExitWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding:
        const EdgeInsets.symmetric(horizontal: 8.0),
        child: InkWell(
          onTap: () {
            //show dialog to exit group
            showAnimatedDialog(
              context: context,
              title: "Exit Group",
              content:
              "Are you sure you want to exit this group?",
              textAction: "Exit",
              onActionTap: (value) {
                if (value) {
                  //exit group
                  // _bloc.exitGroup();
                  // Navigator.pop(context);
                }
              },
            );
          },
          child: SettingListTileWidget(
            title: "Exit Group",
            icon: Icons.exit_to_app,
            iconColor: Colors.red,
          ),
        ),
      ),
    );
  }
}
