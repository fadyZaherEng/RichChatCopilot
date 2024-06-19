import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rich_chat_copilot/lib/src/core/base/widget/base_stateful_widget.dart';
import 'package:rich_chat_copilot/lib/src/core/utils/massage_type.dart';
import 'package:rich_chat_copilot/lib/src/di/data_layer_injector.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/login/user.dart';
import 'package:rich_chat_copilot/lib/src/domain/usecase/get_user_use_case.dart';
import 'package:rich_chat_copilot/lib/src/presentation/blocs/chats/chats_bloc.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/chat/widgets/bottom_chat_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/chat/widgets/chat_app_bar_widget.dart';

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
        _massageFocusNode.requestFocus();
        _massagesScrollController
            .jumpTo(_massagesScrollController.position.maxScrollExtent);
      }
      if (state is SendTextMessageError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.message),
        ));
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          flexibleSpace: Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 5, end: 10, top: 18, bottom: 0),
            child: ChatAppBarWidget(friendId: widget.friendId),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.separated(
                controller: _massagesScrollController,
                shrinkWrap: true,
                itemCount: 50,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  return const ListTile(
                    title: Text('title'),
                    subtitle: Text('subtitle'),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
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
}
