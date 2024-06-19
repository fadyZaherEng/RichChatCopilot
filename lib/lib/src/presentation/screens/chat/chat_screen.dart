import 'package:date_format/date_format.dart' as df;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:rich_chat_copilot/generated/l10n.dart';
import 'package:rich_chat_copilot/lib/src/config/theme/color_schemes.dart';
import 'package:rich_chat_copilot/lib/src/core/base/widget/base_stateful_widget.dart';
import 'package:rich_chat_copilot/lib/src/core/utils/massage_type.dart';
import 'package:rich_chat_copilot/lib/src/di/data_layer_injector.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/chat/massage.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/login/user.dart';
import 'package:rich_chat_copilot/lib/src/domain/usecase/get_user_use_case.dart';
import 'package:rich_chat_copilot/lib/src/presentation/blocs/chats/chats_bloc.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/chat/widgets/bottom_chat_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/chat/widgets/chat_app_bar_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/chat/widgets/current_massage_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/chat/widgets/receiver_massage_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/widgets/cricle_loading_widget.dart';

class ChatScreen extends BaseStatefulWidget {
  final String friendId;
  final String friendName;
  final String friendImage;
  final String groupId;

  const ChatScreen({
    super.key,
    required this.friendId,
    required this.friendName,
    required this.friendImage,
    required this.groupId,
  });

  @override
  BaseState<ChatScreen> baseCreateState() => _ChatScreenState();
}

class _ChatScreenState extends BaseState<ChatScreen> {
  bool _isGroupChat = false;
  TextEditingController _massageController = TextEditingController();
  ScrollController _massagesScrollController = ScrollController();
  FocusNode _massageFocusNode = FocusNode();

  ChatsBloc get _bloc => BlocProvider.of<ChatsBloc>(context);
  UserModel currentUser = UserModel();

  @override
  void initState() {
    super.initState();
    currentUser = GetUserUseCase(injector())();
    _isGroupChat = widget.groupId.isNotEmpty;
    //add list view scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _massagesScrollController
          .jumpTo(_massagesScrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<ChatsBloc, ChatsState>(listener: (context, state) {
      if (state is SendTextMessageSuccess) {
        _massageController.clear();
        // _massageFocusNode.requestFocus();
        // _massagesScrollController
        //     .jumpTo(_massagesScrollController.position.maxScrollExtent);
      }
      if (state is SendTextMessageError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.message),
        ));
      }
    }, builder: (context, state) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            ChatAppBarWidget(friendId: widget.friendId),
            Expanded(
              child: StreamBuilder<List<Massage>>(
                stream: _bloc.getMessagesStream(
                  receiverId: widget.friendId,
                  userId: currentUser.uId,
                  isGroup: widget.groupId,
                ),
                builder: (context, snapshot) {
                  // if (snapshot.connectionState == ConnectionState.waiting) {
                  //   return const CircleLoadingWidget();
                  // }
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
                        S.of(context).startConversation,
                        style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: ColorSchemes.black,
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    final massages = snapshot.data!;
                    return GroupedListView<dynamic, DateTime>(
                      reverse: true,
                      elements: massages,
                      groupBy: (massage) => DateTime(massage.timeSent.year,
                          massage.timeSent.month, massage.timeSent.day),
                      groupHeaderBuilder: (massage) => _buildDateWidget(
                        context: context,
                        dateTime: massage.timeSent,
                      ),
                      useStickyGroupSeparators: true,
                      floatingHeader: true,
                      order: GroupedListOrder.ASC,
                      itemBuilder: (context, massage) {
                        bool isMe = massage.senderId == currentUser.uId;
                        return isMe
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: CurrentMassageWidget(massage: massage),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: ReceiverMassageWidget(massage: massage),
                              );
                      },
                      itemComparator: (massage1, massage2) =>
                          massage1.timeSent.compareTo(massage2.timeSent),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            const SizedBox(height: 15),
            BottomChatWidget(
              friendId: widget.friendId,
              friendName: widget.friendName,
              friendImage: widget.friendImage,
              groupId: widget.groupId,
              textEditingController: _massageController,
              focusNode: _massageFocusNode,
              onTextChange: (String value) {
                _massageController.text = value;
              },
              onAttachPressed: () {},
              onCameraPressed: () {},
              onSendPressed: () {
                //TODO: send message
                _sendTextMassageToFirestore();
              },
            ),
          ],
        ),
      );
    });
  }

  void _sendTextMassageToFirestore() async {
    _bloc.add(SendTextMessageEvent(
      sender: currentUser,
      receiverId: widget.friendId,
      receiverName: widget.friendName,
      receiverImage: widget.friendImage,
      message: _massageController.text,
      massageType: MassageType.text,
      groupId: widget.groupId,
    ));
  }

  @override
  void dispose() {
    _massageController.dispose();
    _massagesScrollController.dispose();
    _massageFocusNode.dispose();
    super.dispose();
  }

  _buildDateWidget({
    required BuildContext context,
    required DateTime dateTime,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        df.formatDate(dateTime, [df.M, ' ', df.d]),
        style: GoogleFonts.openSans(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: ColorSchemes.black,
        ),
      ),
    );
  }
}
