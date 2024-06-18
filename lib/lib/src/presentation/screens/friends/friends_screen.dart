import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rich_chat_copilot/generated/l10n.dart';
import 'package:rich_chat_copilot/lib/src/config/routes/routes_manager.dart';
import 'package:rich_chat_copilot/lib/src/config/theme/color_schemes.dart';
import 'package:rich_chat_copilot/lib/src/core/base/widget/base_stateful_widget.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/login/user.dart';
import 'package:rich_chat_copilot/lib/src/presentation/blocs/friends/friends_bloc.dart';
import 'package:rich_chat_copilot/lib/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/widgets/user_image_widget.dart';

class FriendsScreen extends BaseStatefulWidget {
  const FriendsScreen({super.key});

  @override
  BaseState<FriendsScreen> baseCreateState() => _FriendsScreenState();
}

class _FriendsScreenState extends BaseState<FriendsScreen> {
  FriendsBloc get _bloc => BlocProvider.of<FriendsBloc>(context);
  final _searchController = TextEditingController();
  List<UserModel> _friends = [];

  @override
  void initState() {
    super.initState();
    _bloc.add(GetFriends());
    // _friends.add(UserModel(
    //   name: "John Doe",
    //   aboutMe: "I am a software engineer.",
    //   image: "https://i.pravatar.cc/300",
    // ));
    // _friends.add(UserModel(
    //   name: "John Doe",
    //   aboutMe: "I am a software engineer.",
    //   image: "https://i.pravatar.cc/300",
    // ));
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<FriendsBloc, FriendsState>(
      listener: (context, state) {
        if (state is GetFriendsSuccess) {
          _friends = state.friends;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: buildAppBarWidget(context,
              title: S.of(context).friends,
              isHaveBackButton: true, onBackButtonPressed: () {
            Navigator.pop(context);
          }),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CupertinoSearchTextField(
                  placeholder: S.of(context).search,
                  prefixIcon: const Icon(CupertinoIcons.search),
                  onTap: () {},
                  onChanged: (value) {
                    _searchController.text = value;
                    setState(() {});
                    //filter stream based on search
                  },
                  controller: _searchController,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: _friends.isEmpty
                    ? Center(
                        child: Text(
                          S.of(context).noFriendsYet,
                          style: GoogleFonts.openSans(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ColorSchemes.gray,
                          ),
                        ),
                      )
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _friends.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 15,
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsetsDirectional.only(start: 0),
                            child: ListTile(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.profileScreen,
                                    arguments: {"userId": _friends[index].uId});
                              },
                              leading: UserImageWidget(
                                image: _friends[index].image,
                                width: 50,
                                height: 50,
                              ),
                              title: Text(
                                _friends[index].name,
                                style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: ColorSchemes.black,
                                ),
                              ),
                              subtitle: Text(
                                _friends[index].aboutMe,
                                style: GoogleFonts.openSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: ColorSchemes.black,
                                ),
                              ),
                              trailing: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorSchemes.iconBackGround,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () {
                                  //ToDO navigate to chat screen
                                  Navigator.pushNamed(
                                      context, Routes.chatWithFriendScreen,
                                      arguments: {
                                        "friendId": _friends[index].uId,
                                        "friendName": _friends[index].name,
                                        "friendImage": _friends[index].image,
                                        "groupId": ""
                                      });
                                },
                                child: Text(
                                  S.of(context).chat.toUpperCase(),
                                  style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: ColorSchemes.primary,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              )
            ],
          ),
        );
      },
    );
  }
}
