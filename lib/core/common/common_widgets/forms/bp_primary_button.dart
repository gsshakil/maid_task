// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:maids_task/core/constants/color_constants.dart';

class BlueprintPrimaryButton extends StatelessWidget {
  const BlueprintPrimaryButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
    this.height = 50,
    this.backgroundColorOverride,
    this.textColorOverride,
    this.disabledTextColorOverride,
    this.textStyleOverride,
  });

  final String title;
  final Function()? onPressed;
  final bool isLoading;
  final double height;
  final Color? backgroundColorOverride;
  final Color? textColorOverride;
  final Color? disabledTextColorOverride;
  final TextStyle? textStyleOverride;

  @override
  Widget build(BuildContext context) {
    final isDisabled = (onPressed == null);

    final backgroundColor = backgroundColorOverride ?? primaryDefault;
    final textColor = textColorOverride ?? textSecondary;
    final disabledTextColor = disabledTextColorOverride ?? textHint;
    const borderRadius = 8.0;

    return ElevatedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(0.0),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return backgroundColor.withOpacity(0.4);
              }
              return backgroundColor; // Use the component's default.
            },
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius)),
          )),
      onPressed: isLoading ? null : onPressed,
      child: SizedBox(
        height: height,
        child: Center(
          child: isLoading
              ? SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                    color: isDisabled ? disabledTextColor : textColor,
                  ),
              )
              : Text(
                  title,
                  style: isDisabled
                      ? const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: textHint,
                        )
                      : const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: textInverse,
                        ),
                ),
        ),
      ),
    );
  }
}
