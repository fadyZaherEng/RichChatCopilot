import 'package:flutter/material.dart';
import 'package:rich_chat_copilot/lib/src/core/base/widget/base_stateful_widget.dart';

class PublicGroupScreen extends BaseStatefulWidget {
  const PublicGroupScreen({super.key});

  @override
  BaseState<PublicGroupScreen> baseCreateState() => _PublicGroupScreenState();
}

class _PublicGroupScreenState extends BaseState<PublicGroupScreen> {
  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Text('Public Group Screen'),
        )
    );
  }
}
