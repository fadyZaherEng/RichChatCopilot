import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CircleLoadingWidget extends StatelessWidget {
  const CircleLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: LoadingAnimationWidget.threeArchedCircle(
          color: Theme.of(context).colorScheme.primary,
          size: 50,
        ));
  }
}
