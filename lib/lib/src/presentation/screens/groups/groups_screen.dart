import 'package:flutter/material.dart';
import 'package:rich_chat_copilot/lib/src/core/base/widget/base_stateful_widget.dart';

class GroupsScreen extends BaseStatefulWidget {
  const GroupsScreen({super.key});

  @override
  BaseState<GroupsScreen> baseCreateState() => _GroupsScreenState();
}

class _GroupsScreenState extends BaseState<GroupsScreen> {
  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groups'),
      ),
      body: const Center(
        child: Text('Groups'),
      ),
    );
  }
}
