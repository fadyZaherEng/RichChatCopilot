import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rich_chat_copilot/generated/l10n.dart';
import 'package:rich_chat_copilot/lib/src/config/routes/routes_manager.dart';
import 'package:rich_chat_copilot/lib/src/config/theme/color_schemes.dart';
import 'package:rich_chat_copilot/lib/src/core/base/widget/base_stateful_widget.dart';
import 'package:rich_chat_copilot/lib/src/core/resources/image_paths.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/login/user.dart';
import 'package:rich_chat_copilot/lib/src/presentation/blocs/friends_requests/friends_requests_bloc.dart';
import 'package:rich_chat_copilot/lib/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/widgets/custom_snack_bar_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/widgets/user_image_widget.dart';

class FriendRequestsScreen extends BaseStatefulWidget {
  const FriendRequestsScreen({super.key});

  @override
  BaseState<FriendRequestsScreen> baseCreateState() =>
      _FriendRequestsScreenState();
}

class _FriendRequestsScreenState extends BaseState<FriendRequestsScreen> {
  FriendsRequestsBloc get _bloc =>
      BlocProvider.of<FriendsRequestsBloc>(context);
  final _searchController = TextEditingController();
  List<UserModel> _friendsRequests = [];

  @override
  void initState() {
    super.initState();
    _bloc.add(GetFriendsRequestsEvent());
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<FriendsRequestsBloc, FriendsRequestsState>(
      listener: (context, state) {
        if (state is GetFriendsRequestsSuccess) {
          _friendsRequests = state.friendsRequests;
        } else if (state is AcceptFriendRequestsSuccess) {
          CustomSnackBarWidget.show(
            context: context,
            message: S.of(context).friendRequestAccepted,
            path: ImagePaths.icSuccess,
            backgroundColor: ColorSchemes.green,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: buildAppBarWidget(context,
              title: S.of(context).friendsRequests,
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
                child: _friendsRequests.isEmpty
                    ? Center(
                        child: Text(
                          S.of(context).noFriendRequestsYet,
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
                        itemCount: _friendsRequests.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 15);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsetsDirectional.only(start: 0),
                            child: ListTile(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.profileScreen, arguments: {
                                  "userId": _friendsRequests[index].uId
                                });
                              },
                              leading: UserImageWidget(
                                image: _friendsRequests[index].image,
                                width: 50,
                                height: 50,
                              ),
                              title: Text(
                                _friendsRequests[index].name,
                                style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: ColorSchemes.black,
                                ),
                              ),
                              subtitle: Text(
                                _friendsRequests[index].aboutMe,
                                style: GoogleFonts.openSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: ColorSchemes.black,
                                ),
                              ),
                              trailing: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:  Theme.of(context).cardColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () {
                                  //TODO: accept request
                                  _bloc.add(AcceptFriendRequestEvent(
                                      friendId: _friendsRequests[index].uId));
                                },
                                child: Text(
                                  S.of(context).accept.toUpperCase(),
                                  style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary,
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
