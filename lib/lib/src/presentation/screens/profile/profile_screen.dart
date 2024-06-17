import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rich_chat_copilot/generated/l10n.dart';
import 'package:rich_chat_copilot/lib/src/config/routes/routes_manager.dart';
import 'package:rich_chat_copilot/lib/src/config/theme/color_schemes.dart';
import 'package:rich_chat_copilot/lib/src/core/base/widget/base_stateful_widget.dart';
import 'package:rich_chat_copilot/lib/src/core/utils/constants.dart';
import 'package:rich_chat_copilot/lib/src/data/source/local/single_ton/firebase_single_ton.dart';
import 'package:rich_chat_copilot/lib/src/di/data_layer_injector.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/login/user.dart';
import 'package:rich_chat_copilot/lib/src/domain/usecase/get_user_use_case.dart';
import 'package:rich_chat_copilot/lib/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/widgets/user_image_widget.dart';

class ProfileScreen extends BaseStatefulWidget {
  final String userId;

  const ProfileScreen({super.key, required this.userId});

  @override
  BaseState<ProfileScreen> baseCreateState() => _ProfileScreenState();
}

class _ProfileScreenState extends BaseState<ProfileScreen> {
  UserModel _currentUser = UserModel();
  UserModel _otherUser = UserModel();

  @override
  void initState() {
    super.initState();
    _currentUser = GetUserUseCase(injector())();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWidget(
        context,
        title: S.of(context).profile,
        actionWidget: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.settingsScreen);
            },
            icon: const Icon(
              Icons.settings,
              color: ColorSchemes.black,
            )),
        isHaveBackButton: true,
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
      ),
      body: StreamBuilder(
        stream: FirebaseSingleTon.db
            .collection(Constants.users)
            .doc(_currentUser.uId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            _otherUser = UserModel.fromJson(snapshot.data!.data()!);
            return Center(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      //TODO: navigate to user profile screen
                    },
                    child: UserImageWidget(
                      width: 100,
                      height: 100,
                      image: _otherUser.image,
                      isBorder: false,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _otherUser.name,
                    style: GoogleFonts.openSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: ColorSchemes.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildDivider(),
                        const SizedBox(width: 10),
                        Text(
                          _otherUser.aboutMe,
                          style: GoogleFonts.openSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: ColorSchemes.black,
                          ),
                        ),
                        const SizedBox(width: 10),
                        _buildDivider(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _otherUser.aboutMe,
                    style: GoogleFonts.openSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: ColorSchemes.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildFriendRequestButton(
                      currentUser: _currentUser, otherUser: _otherUser),
                  const SizedBox(height: 10),
                  _buildFriendsButton(
                      currentUser: _currentUser, otherUser: _otherUser),
                  const SizedBox(height: 10),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildFriendRequestButton({
    required UserModel currentUser,
    required UserModel otherUser,
  }) {
    if (currentUser.uId == otherUser.uId) {
      if (otherUser.friendsRequestsUIds.isNotEmpty) {
        return _buildButton(
            text: S.of(context).viewFriendRequests,
            onPressed: () {
              //TODO: navigate to friend requests screen
            });
      } else {
        return const SizedBox.shrink();
      }
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildFriendsButton({
    required UserModel currentUser,
    required UserModel otherUser,
  }) {
    if (currentUser.uId == otherUser.uId && otherUser.friendsUIds.isNotEmpty) {
      return _buildButton(
        text: S.of(context).viewFriends,
        onPressed: () {
          //TODO: navigate to friends screen
        },
      );
    } else {
      if (currentUser.uId == otherUser.uId) {
        return _buildButton(
          text: S.of(context).sendFriendRequests,
          onPressed: () {
            //TODO: send friend request
          },
        );
      } else {
        return const SizedBox.shrink();
      }
    }
  }

  Widget _buildButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorSchemes.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
            text.toUpperCase(),
            style: GoogleFonts.openSans(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: ColorSchemes.white,
            )),
      ),
    );
  }

  _buildDivider() =>const SizedBox(
    height: 40,
    width: 40,
    child: Divider(
      color: ColorSchemes.gray,
      thickness: 1,
    ),
  );
}
