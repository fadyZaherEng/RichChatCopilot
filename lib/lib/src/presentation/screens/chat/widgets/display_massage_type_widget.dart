import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rich_chat_copilot/lib/src/config/routes/routes_manager.dart';
import 'package:rich_chat_copilot/lib/src/core/utils/massage_type.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/chat/widgets/show_audio_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/chat/widgets/show_video_widget.dart';

class DisplayMassageTypeWidget extends StatelessWidget {
  final String massage;
  final MassageType massageType;
  final Color color;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final BuildContext context;
  final bool isReplying;

  const DisplayMassageTypeWidget({
    super.key,
    required this.massageType,
    required this.massage,
    required this.color,
    this.maxLines,
    this.textOverflow,
    required this.context,
    required this.isReplying,
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
          style: TextStyle(fontSize: 16, color: color, overflow: textOverflow),
          maxLines: maxLines,
        );
      case MassageType.image:
        return isReplying
            ? const Icon(Icons.image)
            : CachedNetworkImage(imageUrl: massage, fit: BoxFit.cover);
      case MassageType.video:
        return isReplying
            ? const Icon(Icons.video_collection)
            : ShowVideoWidget(
                videoPath: massage,
                color: color,
                onTap: () {
                  Navigator.pushNamed(context, Routes.fullVideoScreen,
                      arguments: {'videoPath': massage});
                },
              );
      case MassageType.audio:
        return isReplying
            ? const Icon(Icons.audiotrack)
            : ShowAudioWidget(audioPath: massage, textDurationColor: color);
      case MassageType.file:
        return CachedNetworkImage(imageUrl: massage);
      default:
        return Text(
          massage,
          style: TextStyle(fontSize: 16, color: color, overflow: textOverflow),
          maxLines: maxLines,
        );
    }
  }
}
