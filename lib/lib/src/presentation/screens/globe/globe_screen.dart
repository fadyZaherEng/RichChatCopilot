import 'package:flutter/material.dart';
import 'package:rich_chat_copilot/lib/src/core/base/widget/base_stateful_widget.dart';

class GlobeScreen extends BaseStatefulWidget {
  const GlobeScreen({super.key});

  @override
  BaseState<GlobeScreen> baseCreateState() => _GlobeScreenState();
}

class _GlobeScreenState extends BaseState<GlobeScreen> {
  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Globe'),
      ),
      body: const Center(
        child: Text('Globe'),
      ),
    );
  }
}
