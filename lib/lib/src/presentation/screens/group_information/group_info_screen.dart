import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rich_chat_copilot/lib/src/presentation/blocs/group/group_bloc.dart';
import 'package:rich_chat_copilot/lib/src/presentation/widgets/user_image_widget.dart';

class GroupInformationScreen extends StatefulWidget {
  const GroupInformationScreen({super.key});

  @override
  State<GroupInformationScreen> createState() => _GroupInformationScreenState();
}

class _GroupInformationScreenState extends State<GroupInformationScreen> {
  GroupBloc get _bloc => BlocProvider.of<GroupBloc>(context);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupBloc, GroupState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Group Information"),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: UserImageWidget(
                                  image: _bloc.group.groupLogo,
                                  width: 80,
                                  height: 80,
                                  isBorder: false,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                children: [
                                  Text(
                                    _bloc.group.groupName,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    _bloc.group.groupDescription,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
