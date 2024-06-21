import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rich_chat_copilot/lib/src/core/utils/massage_type.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/chat/widgets/show_audio_widget.dart';

class DisplayMassageTypeWidget extends StatelessWidget {
  final String massage;
  final MassageType massageType;
  final Color color;
  final int? maxLines;
  final TextOverflow? textOverflow;

  const DisplayMassageTypeWidget({
    super.key,
    required this.massageType,
    required this.massage,
    required this.color,
    this.maxLines,
    this.textOverflow,
  });

  @override
  Widget build(BuildContext context) {
    return getMassageTypeWidget();
  }

  Widget getMassageTypeWidget() {
    switch (massageType) {
      case MassageType.text:
        return Text(
          massage,
          style: TextStyle(
            fontSize: 16,
            color: color,
            overflow: textOverflow,
          ),
          maxLines: maxLines,
        );
      case MassageType.image:
        return CachedNetworkImage(imageUrl: massage, fit: BoxFit.fill);
      case MassageType.video:
        return CachedNetworkImage(imageUrl: massage);
      case MassageType.audio:
        return ShowAudioWidget(audioPath: massage,textDurationColor: color);
      case MassageType.file:
        return CachedNetworkImage(imageUrl: massage);
      default:
        return Text(
          massage,
          style: TextStyle(
            fontSize: 16,
            color: color,
            overflow: textOverflow,
          ),
          maxLines: maxLines,
        );
    }
  }
}
