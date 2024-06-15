import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rich_chat_copilot/generated/l10n.dart';
import 'package:rich_chat_copilot/lib/src/config/theme/color_schemes.dart';
import 'package:rich_chat_copilot/lib/src/core/base/widget/base_stateful_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/otp/widgets/otp_widget.dart';

class OtpScreen extends BaseStatefulWidget {
  final String phoneNumber;
  final String verificationCode;

  const OtpScreen({
    super.key,
    required this.phoneNumber,
    required this.verificationCode,
  });

  @override
  BaseState<OtpScreen> baseCreateState() => _OtpScreenState();
}

class _OtpScreenState extends BaseState<OtpScreen> {
  TextEditingController _otpController = TextEditingController();
  String _otpCode = '';

  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: ColorSchemes.primary.withOpacity(0.03),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Text(
                  S.of(context).verification,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 30, color: ColorSchemes.black),
                ),
                const SizedBox(height: 15),
                Text(
                  S.of(context).enterThe6Digit,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: ColorSchemes.black),
                ),
                const SizedBox(height: 15),
                Text(
                  widget.phoneNumber,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: ColorSchemes.black),
                ),
                const SizedBox(height: 30),
                OtpWidget(
                  length: 6,
                  textEditingController: _otpController,
                  onCompleted: (pin) {
                    setState(() {
                      _otpCode = pin;
                    });
                  },
                ),
                const SizedBox(height: 30),
                Text(
                  S.of(context).didReceiveTheCode,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: ColorSchemes.black),
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    //to do resend code
                    _resendCode(context);
                  },
                  child: Text(
                    S.of(context).resendCode,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: ColorSchemes.primary),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _resendCode(BuildContext context) async {
    final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationCode, smsCode: _otpCode);
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      //check if user exists
      //if exists navigate to home
      // get user info
      //save user info
      //if user not exists navigate to user info
    }).catchError((onError) {});
  }
}
