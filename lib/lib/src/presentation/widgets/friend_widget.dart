import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rich_chat_copilot/generated/l10n.dart';
import 'package:rich_chat_copilot/lib/src/config/routes/routes_manager.dart';
import 'package:rich_chat_copilot/lib/src/config/theme/color_schemes.dart';
import 'package:rich_chat_copilot/lib/src/core/utils/enum/friend_view_type.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/login/user.dart';
import 'package:rich_chat_copilot/lib/src/presentation/widgets/user_image_widget.dart';

class FriendWidget extends StatelessWidget {
  final UserModel user;
  final FriendViewType friendViewType;
  final void Function()? onAcceptRequest;

  const FriendWidget({
    super.key,
    required this.user,
    required this.friendViewType,
    this.onAcceptRequest,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () {
        if (friendViewType == FriendViewType.friend) {
          //ToDO navigate to chat screen
          Navigator.pushNamed(context, Routes.chatWithFriendScreen, arguments: {
            "friendId": user.uId,
            "friendName": user.name,
            "friendImage": user.image,
            "groupId": ""
          });
        } else if (friendViewType == FriendViewType.allUsers) {
          Navigator.pushNamed(context, Routes.profileScreen, arguments: {
            "userId": user.uId,
          });
        } else {
          //check the checkbox
        }
      },
      leading: UserImageWidget(
        image: user.image,
        width: 50,
        height: 50,
      ),
      title: Text(
        user.name,
        style: GoogleFonts.openSans(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: ColorSchemes.black,
        ),
      ),
      subtitle: Text(
        user.aboutMe,
        style: GoogleFonts.openSans(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: ColorSchemes.black,
        ),
      ),
      trailing: friendViewType == FriendViewType.friendRequest
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () {
                //TODO: accept request
                // _bloc.add(AcceptFriendRequestEvent(friendId: user.uId));
                if (onAcceptRequest != null) onAcceptRequest!();
              },
              child: Text(
                S.of(context).accept.toUpperCase(),
                style: GoogleFonts.openSans(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            )
          : friendViewType == FriendViewType.groupView
              ? Checkbox(
                  value: false,
                  onChanged: (value) {
                    //TODO: check the checkbox
                  })
              : null,
    );
  }
}
