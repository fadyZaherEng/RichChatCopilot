import 'package:flutter/material.dart';
import 'package:rich_chat_copilot/generated/l10n.dart';
import 'package:rich_chat_copilot/lib/src/config/theme/color_schemes.dart';
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
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: ColorSchemes.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(S.of(context).welcomeMessage),
            ],
          ),
        ),
      ),
    );
  }

  void onChanged(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }
}
