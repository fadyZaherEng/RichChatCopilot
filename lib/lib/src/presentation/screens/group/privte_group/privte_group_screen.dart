import 'package:flutter/material.dart';
import 'package:rich_chat_copilot/lib/src/core/base/widget/base_stateful_widget.dart';

class PrivateGroupScreen extends BaseStatefulWidget {
  const PrivateGroupScreen({super.key});

  @override
  BaseState<PrivateGroupScreen> baseCreateState() => _PrivateGroupScreenState();
}

class _PrivateGroupScreenState extends BaseState<PrivateGroupScreen> {
  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Private Group Screen'),
      )
    );
  }
}
