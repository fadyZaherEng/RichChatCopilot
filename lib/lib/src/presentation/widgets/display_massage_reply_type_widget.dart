import 'package:flutter/material.dart';
import 'package:rich_chat_copilot/lib/src/core/utils/massage_type.dart';

class MassageReplyTypeWidget extends StatelessWidget {
  final MassageType massageType;
  final String massage;

  const MassageReplyTypeWidget({
    required this.massageType,
    required this.massage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget massageReplayShow() {
      switch (massageType) {
        case MassageType.text:
          return Text(
            massage,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        case MassageType.image:
          return const Row(
            children: [
              Icon(Icons.image_outlined),
              SizedBox(
                width: 10,
              ),
              Text(
                "Image",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          );
        case MassageType.video:
          return const Row(
            children: [
              Icon(Icons.video_library_outlined),
              SizedBox(
                width: 10,
              ),
              Text(
                "Video",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          );
        case MassageType.audio:
          return const Row(
            children: [
              Icon(Icons.audiotrack_outlined),
              SizedBox(
                width: 10,
              ),
              Text(
                "Audio",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          );
        case MassageType.file:
          return const Row(
            children: [
              Icon(Icons.file_copy_outlined),
              SizedBox(
                width: 10,
              ),
              Text(
                "File",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          );
        default:
          return Text(
            massage,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
      }
    }

    return massageReplayShow();
  }
}
