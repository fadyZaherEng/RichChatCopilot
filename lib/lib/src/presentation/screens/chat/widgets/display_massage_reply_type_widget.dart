import 'package:flutter/material.dart';
import 'package:rich_chat_copilot/generated/l10n.dart';
import 'package:rich_chat_copilot/lib/src/core/utils/massage_type.dart';

class MassageReplyTypeWidget extends StatelessWidget {
  final MassageType massageType;
  final String massage;
  final BuildContext context;

  const MassageReplyTypeWidget({
    required this.massageType,
    required this.massage,
    required this.context,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return massageReplayShow();
  }
  Widget massageReplayShow() {
    switch (massageType) {
      case MassageType.text:
        return Text(
          massage,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        );
      case MassageType.image:
        return  Row(
          children: [
            const Icon(Icons.image_outlined),
            const SizedBox(
              width: 10,
            ),
            Text(
              S.of(context).image,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        );
      case MassageType.video:
        return  Row(
          children: [
            const Icon(Icons.video_library_outlined),
            const SizedBox(
              width: 10,
            ),
            Text(
              S.of(context).video,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        );
      case MassageType.audio:
        return  Row(
          children: [
             Icon(Icons.audiotrack_outlined,color: Theme.of(context).cardColor,),
            const SizedBox(
              width: 10,
            ),
            Text(
              S.of(context).audio,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Theme.of(context).cardColor),
            ),
          ],
        );
      case MassageType.file:
        return  Row(
          children: [
            const Icon(Icons.file_copy_outlined),
            const SizedBox(
              width: 10,
            ),
            Text(
              S.of(context).file,
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

}
