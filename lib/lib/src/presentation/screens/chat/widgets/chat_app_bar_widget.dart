import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rich_chat_copilot/lib/src/config/routes/routes_manager.dart';
import 'package:rich_chat_copilot/lib/src/config/theme/color_schemes.dart';
import 'package:rich_chat_copilot/lib/src/core/base/widget/base_stateful_widget.dart';
import 'package:rich_chat_copilot/lib/src/core/utils/constants.dart';
import 'package:rich_chat_copilot/lib/src/data/source/local/single_ton/firebase_single_ton.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/login/user.dart';
import 'package:rich_chat_copilot/lib/src/presentation/widgets/user_image_widget.dart';

class ChatAppBarWidget extends BaseStatefulWidget {
  final String friendId;

  const ChatAppBarWidget({
    super.key,
    required this.friendId,
  });

  @override
  BaseState<ChatAppBarWidget> baseCreateState() => _ChatAppBarWidgetState();
}

class _ChatAppBarWidgetState extends BaseState<ChatAppBarWidget> {
  @override
  Widget baseBuild(BuildContext context) {
    //stream to user id
    return StreamBuilder(
      stream: FirebaseSingleTon.db
          .collection(Constants.users)
          .doc(widget.friendId)
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          UserModel user = UserModel.fromJson(snapshot.data.data()!);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    //TODO: navigate to profile screen
                    Navigator.pushNamed(context, Routes.profileScreen,
                        arguments: {"userId": user.uId});
                  },
                  child: UserImageWidget(
                    image: user.image,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ColorSchemes.black,
                      ),
                    ),
                    Text(
                      user.isOnline ? "Online" : "Offline",
                      style: GoogleFonts.openSans(
                        fontSize: 11,
                        fontWeight: FontWeight.normal,
                        color: ColorSchemes.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
