import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rich_chat_copilot/lib/src/domain/entities/group/group.dart';
import 'package:rich_chat_copilot/lib/src/presentation/blocs/group/group_bloc.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/chat/widgets/group_member_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/widgets/user_image_widget.dart';

class GroupChatAppBar extends StatefulWidget {
  final String groupID;

  const GroupChatAppBar({
    super.key,
    required this.groupID,
  });

  @override
  State<GroupChatAppBar> createState() => _GroupChatAppBarState();
}

class _GroupChatAppBarState extends State<GroupChatAppBar> {
  GroupBloc get _bloc => BlocProvider.of<GroupBloc>(context);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.getGroupStream(groupId: widget.groupID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return const Center(child: CircularProgressIndicator());
        // }

        if (snapshot.hasData) {
          final group =
              Group.fromMap(snapshot.data!.data()! as Map<String, dynamic>);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    //TODO: navigate to group settings
                  },
                  child: UserImageWidget(
                    image: group.groupLogo,
                    width: 40,
                    height: 40,
                    isBorder: false,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(group.groupName),
                      const SizedBox(
                        height: 5,
                      ),
                      GroupMemberWidget(membersUIDS: group.membersUIDS),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
