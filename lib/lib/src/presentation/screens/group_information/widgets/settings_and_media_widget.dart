import 'package:flutter/material.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/create_group/widgets/setting_list_tile_widget.dart';

class SettingsAndMediaWidget extends StatelessWidget {
  const SettingsAndMediaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 2,
        child: Column(
          children: [
            SettingListTileWidget(
              title: "Media",
              icon: Icons.image,
              iconColor: Colors.deepPurple,
              onTap: () {
                //navigate to media screen
              },
            ),
            const Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
            SettingListTileWidget(
              title: "Group Settings",
              icon: Icons.settings,
              iconColor: Colors.deepPurple,
              onTap: () {
                //navigate to media screen
              },
            ),
          ],
        ),
      ),
    );
  }
}
