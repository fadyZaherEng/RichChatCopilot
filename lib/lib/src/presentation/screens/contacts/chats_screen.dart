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
                height: 20,
              ),
              Expanded(
                child: StreamBuilder<List<LastMassage>>(
                  stream: _bloc.getChatsLastMassagesStream(
                      userId: GetUserUseCase(injector())().uId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
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
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text(
                          S.of(context).noFoundChatsUntilNow,
                          style: GoogleFonts.openSans(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ColorSchemes.gray,
                          ),
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      return ListView.separated(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            titleAlignment: ListTileTitleAlignment.bottom,
                            title: Text(
                              snapshot.data![index].receiverName,
                              style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: ColorSchemes.black,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                _currentUser.uId ==
                                        snapshot.data![index].senderId
                                    ? "You: ${snapshot.data![index].massage}"
                                    : snapshot.data![index].massage,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: ColorSchemes.gray,
                                ),
                              ),
                            ),
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  snapshot.data![index].receiverImage),
                            ),
                            trailing: Text(
                              DateFormat("hh:mm a").format(
                                snapshot.data![index].timeSent,
                              ),
                              style: GoogleFonts.openSans(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: ColorSchemes.gray,
                              ),
                            ),
                            onTap: () {
                              //TODO: navigate to chat screen
                              Navigator.pushNamed(context, Routes.chatScreen,
                                  arguments: {
                                    "friendId":
                                        snapshot.data![index].receiverId,
                                    "friendName":
                                        snapshot.data![index].receiverName,
                                    "friendImage":
                                        snapshot.data![index].receiverImage,
                                    "groupId": ""
                                  });
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
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
