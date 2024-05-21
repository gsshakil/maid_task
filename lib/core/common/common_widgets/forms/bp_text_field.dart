// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maids_task/core/constants/color_constants.dart';

class BlueprintTextField extends StatelessWidget {
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool readOnly;
  final String? hintText;
  final String label;
  final TextInputAction? inputAction;
  final EdgeInsets contentPadding;
  final int maxLines;
  final Function(String)? valueChanged;
  final double? scrollPadding;
  final bool autoFocus;

  const BlueprintTextField({
    super.key,
    required this.controller,
    this.prefixIcon,
    this.validator,
    this.keyboardType = TextInputType.name,
    this.onTap,
    this.suffixIcon,
    this.numberFormatters = false,
    this.obscureText = false,
    this.hintText,
    required this.label,
    this.inputAction,
    this.maxLines = 1,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 10,
    ),
    this.readOnly = false,
    this.valueChanged,
    this.scrollPadding,
    this.autoFocus = false,
  });
  final bool obscureText, numberFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      scrollPadding: EdgeInsets.only(bottom: scrollPadding ?? 0),
      style: const TextStyle(fontSize: 14),
      validator: validator,
      cursorColor:textPrimary,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        label: Text(
          label,
          style: const TextStyle(fontSize: 14, color: textHint),
        ),
        contentPadding: contentPadding,
        hintStyle: const TextStyle(fontSize: 14, color: textHint),
        hintText: hintText,
        prefixIcon: prefixIcon,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: textHint),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: textHint),
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: suffixIcon,
      ),
      onChanged: (value) =>
          valueChanged != null ? valueChanged!(value) : () => {},
      readOnly: readOnly,
      onTap: onTap,
      maxLines: maxLines,
      obscureText: obscureText,
      textInputAction: inputAction,
      autofocus: autoFocus,
      keyboardType: keyboardType,
      inputFormatters: [
        if (numberFormatters)
          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
      ],
    );
  }
}
