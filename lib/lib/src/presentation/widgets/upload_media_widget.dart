
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rich_chat_copilot/generated/l10n.dart';
import 'package:rich_chat_copilot/lib/src/config/theme/color_schemes.dart';
import 'package:rich_chat_copilot/lib/src/core/resources/image_paths.dart';
import 'package:rich_chat_copilot/lib/src/presentation/widgets/bottom_sheet_widget.dart';

class UploadMediaWidget extends StatefulWidget {
  final Function() onTapCamera;
  final Function() onTapGallery;

  const UploadMediaWidget(
      {Key? key, required this.onTapCamera, required this.onTapGallery})
      : super(key: key);

  @override
  State<UploadMediaWidget> createState() => _UploadMediaWidgetState();
}

class _UploadMediaWidgetState extends State<UploadMediaWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomSheetWidget(
        height: 219,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: widget.onTapGallery,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _cyrcleIcon(
                    boxShadows: [
                      BoxShadow(
                          offset: const Offset(0, 4),
                          color: ColorSchemes.iconBackGround,
                          blurRadius: 24,
                          blurStyle: BlurStyle.normal,
                          spreadRadius: 5),
                    ],
                    imagePath: ImagePaths.icGallery,
                    backgroundColor: ColorSchemes.iconBackGround,
                    iconSize: 28,
                    iconColor: ColorSchemes.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    S
                        .of(context)
                        .gallery,
                    style: Theme
                        .of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(
                        fontSize: 13,
                        letterSpacing: -0.24,
                        color: ColorSchemes.black),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 71,
            ),
            GestureDetector(
              onTap: widget.onTapCamera,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _cyrcleIcon(
                    boxShadows: [
                      BoxShadow(
                          offset: const Offset(0, 4),
                          color: ColorSchemes.iconBackGround,
                          blurRadius: 24,
                          blurStyle: BlurStyle.normal,
                          spreadRadius: 5),
                    ],
                    imagePath: ImagePaths.icCamera,
                    backgroundColor: ColorSchemes.iconBackGround,
                    iconSize: 28,
                    iconColor: ColorSchemes.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    S
                        .of(context)
                        .camera,
                    style: Theme
                        .of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(
                        fontSize: 13,
                        letterSpacing: -0.24,
                        color: ColorSchemes.black),
                  ),
                ],
              ),
            ),
          ],
        ),
        titleLabel: S
            .of(context)
            .uploadMedia);
  }

  Widget _cyrcleIcon({
    required Color backgroundColor,
    required double iconSize,
    required Color iconColor,
    required List<BoxShadow> boxShadows,
    required String imagePath,
  }) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: boxShadows,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.transparent,
          width: 0,
        ),
      ),
      child: SvgPicture.asset(
        imagePath,
        width: iconSize,
        height: iconSize,
        fit: BoxFit.scaleDown,
        color: iconColor,
      ),
    );
  }
}
