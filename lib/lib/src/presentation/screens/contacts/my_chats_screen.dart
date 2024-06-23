import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rich_chat_copilot/generated/l10n.dart';
import 'package:rich_chat_copilot/lib/src/config/routes/routes_manager.dart';
import 'package:rich_chat_copilot/lib/src/config/theme/color_schemes.dart';
import 'package:rich_chat_copilot/lib/src/core/base/widget/base_stateful_widget.dart';
import 'package:rich_chat_copilot/lib/src/di/data_layer_injector.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/chat/last_massage.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/login/user.dart';
import 'package:rich_chat_copilot/lib/src/domain/usecase/get_user_use_case.dart';
import 'package:rich_chat_copilot/lib/src/presentation/blocs/chats/chats_bloc.dart';
import 'package:rich_chat_copilot/lib/src/presentation/widgets/cricle_loading_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/chat/widgets/display_massage_reply_type_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/widgets/user_image_widget.dart';

class ChatsScreen extends BaseStatefulWidget {
  const ChatsScreen({super.key});

  @override
  BaseState<ChatsScreen> baseCreateState() => _ChatsScreenState();
}

class _ChatsScreenState extends BaseState<ChatsScreen> {
  // List<UserModel> _users = [];

  ChatsBloc get _bloc => BlocProvider.of<ChatsBloc>(context);
  final _searchController = TextEditingController();
  UserModel _currentUser = UserModel();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetAllUsersEvent());
    _currentUser = GetUserUseCase(injector())();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<ChatsBloc, ChatsState>(
      listener: (context, state) {
        if (state is GetUserChatsSuccess) {
          // _users = state.users;
        } else if (state is GetUserChatsError) {}
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
              const SizedBox(height: 10),
              Expanded(
                child: StreamBuilder<List<LastMassage>>(
                  stream: _bloc.getChatsLastMassagesStream(
                      userId: GetUserUseCase(injector())().uId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircleLoadingWidget();
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          S.of(context).somethingWentWrong,
                          style: GoogleFonts.openSans(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ColorSchemes.gray,
                          ),
                        ),
                      );
                    }
                    if (!snapshot.hasData ||
                        snapshot.data!.isEmpty ||
                        snapshot.data == null) {
                      return Center(
                        child: Text(
                          S.of(context).noFoundChatsUntilNow,
                          style: GoogleFonts.openSans(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            color: ColorSchemes.black,
                          ),
                        ),
                      );
                    }
                    if (snapshot.hasData &&
                        snapshot.data != null &&
                        snapshot.data!.isNotEmpty) {
                      return ListView.separated(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            titleAlignment: ListTileTitleAlignment.bottom,
                            title: Text(
                              snapshot.data![index].receiverName,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: MassageReplyTypeWidget(
                                massageType: snapshot.data![index].massageType,
                                massage: _currentUser.uId ==
                                        snapshot.data![index].senderId
                                    ? "${S.of(context).you}: ${snapshot.data![index].massage}"
                                    : snapshot.data![index].massage,
                                context: context,
                              ),
                            ),
                            leading: UserImageWidget(
                              image: snapshot.data![index].receiverImage,
                              width: 50,
                              height: 50,
                              isBorder: false,
                            ),
                            trailing: Text(
                              DateFormat("hh:mm a").format(
                                snapshot.data![index].timeSent,
                              ),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            onTap: () {
                              //TODO: navigate to chat screen
                              Navigator.pushNamed(
                                context,
                                Routes.chatWithFriendScreen,
                                arguments: {
                                  "friendId": snapshot.data![index].receiverId,
                                  "friendName":
                                      snapshot.data![index].receiverName,
                                  "friendImage":
                                      snapshot.data![index].receiverImage,
                                  "groupId": ""
                                },
                              );
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                      );
                    } else {
                      return const CircleLoadingWidget();
                    }
                  },
                ),
              ),
            ],
          )),
        );
      },
    );
  }
}
