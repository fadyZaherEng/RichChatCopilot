import 'package:flutter/material.dart';
import 'package:rich_chat_copilot/generated/l10n.dart';
import 'package:rich_chat_copilot/lib/src/core/base/widget/base_stateful_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/user_information/widgets/user_info_body_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/user_information/widgets/user_info_image_widget.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class UserInformationScreen extends BaseStatefulWidget {
  const UserInformationScreen({super.key});

  @override
  BaseState<UserInformationScreen> baseCreateState() =>
      _UserInformationScreenState();
}

class _UserInformationScreenState extends BaseState<UserInformationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final RoundedLoadingButtonController _btnRoundController =
      RoundedLoadingButtonController();

  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(S.of(context).userInformation),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                UserInfoImageWidget(
                  onCameraClicked: () {},
                ),
                UserInfoBodyWidget(
                  nameController: _nameController,
                  onChanged: (value) {
                    setState(() {
                      _nameController.text = value;
                    });
                  },
                  btnRoundController: _btnRoundController,
                  continuePressed: () {
                    _btnRoundController.error();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
