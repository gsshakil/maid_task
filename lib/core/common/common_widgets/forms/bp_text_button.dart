// Flutter imports:
import 'package:flutter/material.dart';

import 'package:maids_task/core/constants/color_constants.dart';

class BlueprintTextButton extends StatelessWidget {
  const BlueprintTextButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
    this.overrideTextStyle,
  });

  final String title;
  final Function()? onPressed;
  final bool isLoading;
  final TextStyle? overrideTextStyle;

  @override
  Widget build(BuildContext context) {
    final isDisabled = (onPressed == null);

    return TextButton(
      onPressed: isLoading ? null : onPressed,
      child: SizedBox(
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : Text(
                  title,
                  style: overrideTextStyle ??
                      TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDisabled ? textHint : primaryDefault,
                      ),
                ),
        ),
      ),
    );
  }
}
