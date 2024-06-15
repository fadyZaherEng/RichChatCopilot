import 'package:flutter/material.dart';
import 'package:rich_chat_copilot/generated/l10n.dart';
import 'package:rich_chat_copilot/lib/src/config/theme/color_schemes.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class UserInfoBodyWidget extends StatelessWidget {
  final TextEditingController nameController;
  final void Function(String value) onChanged;
  final void Function() continuePressed;
  final RoundedLoadingButtonController btnRoundController;

  const UserInfoBodyWidget({
    super.key,
    required this.nameController,
    required this.onChanged,
    required this.btnRoundController,
    required this.continuePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        TextFormField(
          controller: nameController,
          onChanged: (value)=>onChanged(value),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            hintText: S.of(context).enterName,
            labelText: S.of(context).enterName,
          ),
        ),
        const SizedBox(height: 30),
        RoundedLoadingButton(
          controller: btnRoundController,
          onPressed:continuePressed,
          successIcon: Icons.check,
          successColor: Colors.green,
          errorColor: Colors.red,
          color: Theme.of(context).primaryColor,
          child: Text(
              S.of(context).continues,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: ColorSchemes.white)),
        )
      ],
    );
  }
}
