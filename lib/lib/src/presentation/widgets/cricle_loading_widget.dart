import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rich_chat_copilot/lib/src/config/theme/color_schemes.dart';

class CircleLoadingWidget extends StatelessWidget {
  const CircleLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: LoadingAnimationWidget.threeArchedCircle(
          color: ColorSchemes.primary,
          size: 50,
        ));
  }
}
