import 'package:flutter/material.dart';
import 'package:rich_chat_copilot/generated/l10n.dart';
import 'package:rich_chat_copilot/lib/src/core/base/widget/base_stateful_widget.dart';

class HomeScreen extends BaseStatefulWidget {
  const HomeScreen({super.key});

  @override
  BaseState<HomeScreen> baseCreateState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen> {
  bool isDarkMode = false;
  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appTitle,
            style: Theme.of(context).textTheme.titleLarge),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            SwitchListTile(value: isDarkMode, onChanged: onChanged)
          ],
        ),
      )
    );
  }

  void onChanged(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }
}
