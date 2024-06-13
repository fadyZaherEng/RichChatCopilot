import 'package:flutter/material.dart';
import 'package:rich_chat_copilot/generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appTitle,
            style: Theme.of(context).textTheme.titleLarge),
      ),
      body: const Center(
        child: Text("Rich Chats Copilot"),
      ),
    );
  }
}
