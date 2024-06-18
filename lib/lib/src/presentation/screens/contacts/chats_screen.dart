import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rich_chat_copilot/lib/src/core/base/widget/base_stateful_widget.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/login/user.dart';
import 'package:rich_chat_copilot/lib/src/presentation/blocs/chats/chats_bloc.dart';

class ChatsScreen extends BaseStatefulWidget {
  const ChatsScreen({super.key});

  @override
  BaseState<ChatsScreen> baseCreateState() => _ChatsScreenState();
}

class _ChatsScreenState extends BaseState<ChatsScreen> {
  List<UserModel> _users = [];

  ChatsBloc get _bloc => BlocProvider.of<ChatsBloc>(context);

  @override
  void initState() {
    super.initState();
    _bloc.add(GetAllUsersEvent());
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<ChatsBloc, ChatsState>(
      listener: (context, state) {
        if (state is GetUserChatsSuccess) {
          _users = state.users;
        } else if (state is GetUserChatsError) {}
      },
      builder: (context, state) {
        return Scaffold();
      },
    );
  }
}
