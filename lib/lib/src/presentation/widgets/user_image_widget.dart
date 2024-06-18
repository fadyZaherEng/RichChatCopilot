import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rich_chat_copilot/lib/src/config/theme/color_schemes.dart';
import 'package:skeletons/skeletons.dart';

class UserImageWidget extends StatelessWidget {
  final String image;
  final bool isBorder;
  double width;
  double height;

  UserImageWidget({super.key,
    required this.image,
    this.isBorder = true,
    this.width = 40.0,
    this.height = 40.0,});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder: (context, imageProvider) =>
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
                border: isBorder
                    ? Border.all(
                  color: ColorSchemes.primary,
                  width: 2.0,
                )
                    : null),
          ),
      placeholder: (context, url) =>
          SkeletonAvatar(
            style: SkeletonAvatarStyle(
              width: width,
              height: height,
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
      errorWidget: (context, url, error) =>
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: isBorder
                    ? Border.all(
                  color: ColorSchemes.primary,
                  width: 2.0,
                )
                    : null),
            child: const Icon(Icons.error, color: ColorSchemes.red,),
          ),
    );
  }
}
