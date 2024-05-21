// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maids_task/core/constants/color_constants.dart';
import 'package:maids_task/core/extentions/widget_extensions.dart';

class BlueprintOutlineButton extends StatelessWidget {
  const BlueprintOutlineButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
    required this.borderColor,
    required this.textColor,
    this.bgColor = Colors.transparent,
    required this.loadingColor,
    this.svgIconPath,
    this.borderWidth = 2.0,
    this.overrideDefaultStylePadding = false,
  });

  final String title;
  final Function() onPressed;
  final Color borderColor;
  final Color textColor;
  final Color bgColor;
  final Color loadingColor;
  final bool isLoading;
  final String? svgIconPath;
  final double borderWidth;
  final bool overrideDefaultStylePadding;

  @override
  Widget build(BuildContext context) {
    const borderRadius = 8.0;

    ButtonStyle? style;
    if (overrideDefaultStylePadding) {
      style = ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
      );
    }
    return TextButton(
      style: style,
      onPressed: isLoading ? null : onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: bgColor,
          border: Border.all(color: borderColor, width: borderWidth),
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    svgIconPath != null
                        ? SvgPicture.asset(
                            svgIconPath ?? '',
                            // ignore: deprecated_member_use
                            color: primaryDefault,
                          ).padding(right: 10)
                        : const SizedBox(),
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Graphik',
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
