import 'package:flutter/material.dart';
import 'package:rich_chat_copilot/generated/l10n.dart';
import 'package:rich_chat_copilot/lib/src/config/theme/color_schemes.dart';

class CustomRoundedAnimationButton extends StatefulWidget {
  //rounded_loading_button
  final double height;
  final double width;
  final double borderRadius;
  final Color backgroundColor;
  final Color valueColor;
  final Color successColor;
  final Color errorColor;
  final Color textColor;
  final Color borderColor;
  final double borderWidth;
  final IconData successIcon;
  final IconData errorIcon;
  final Function()? onTap;

  const CustomRoundedAnimationButton({
    super.key,
    this.height = 48,
    this.width = 300,
    this.borderRadius = 25,
    this.backgroundColor = ColorSchemes.primary,
    required this.valueColor,
    required this.successColor,
    required this.errorColor,
    this.textColor = ColorSchemes.white,
    required this.borderColor,
    required this.borderWidth,
    this.successIcon = Icons.check,
    this.errorIcon = Icons.close,
    required this.onTap,
  });

  @override
  State<CustomRoundedAnimationButton> createState() =>
      _CustomRoundedAnimationButtonState();
}

class _CustomRoundedAnimationButtonState
    extends State<CustomRoundedAnimationButton> {
  bool isAnimated = false;
  bool isSuccess = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeIn,
      height: widget.height,
      width: isAnimated ? 55 : widget.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: widget.borderColor,
          width: widget.borderWidth,
        ),
      ),
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
          ),
          onPressed: () async {
            setState(() {
              isAnimated = !isAnimated;
              isLoading = !isLoading;
            });
            await Future.delayed(
                const Duration(milliseconds: 250)); //return from api time
            setState(() {
              isSuccess = !isSuccess;
              isLoading = !isLoading;
            });
            widget.onTap?.call();
          },
          child: isAnimated
              ? isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: ColorSchemes.white,
                    ))
                  : isSuccess
                      ? Center(
                          child: Icon(widget.successIcon,
                              color: widget.valueColor))
                      : Center(
                          child:
                              Icon(widget.errorIcon, color: widget.errorColor))
              : Center(
                  child: Text(S.of(context).continues,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: widget.textColor))),
        ),
      ),
    );
  }
}
