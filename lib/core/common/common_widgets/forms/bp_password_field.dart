// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maids_task/core/constants/color_constants.dart';


class BlueprintPasswordField extends StatefulWidget {
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
  final Function(String)? valueChanged;

  const BlueprintPasswordField(
      {super.key,
      required this.controller,
      this.prefixIcon,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.onTap,
      this.suffixIcon,
      this.numberFormatters = false,
      this.hintText,
      required this.label,
      this.inputAction,
      this.readOnly = false,
      this.valueChanged});
  final bool numberFormatters;

  @override
  State<BlueprintPasswordField> createState() => _BlueprintPasswordFieldState();
}

class _BlueprintPasswordFieldState extends State<BlueprintPasswordField> {
  bool _isHidden = true;

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: const TextStyle(fontSize: 14),
      validator: widget.validator,
      cursorColor:primaryDefault,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        label: Text(
          widget.label,
          style: const TextStyle(fontSize: 14, color: textHint),
        ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(fontSize: 14, color: textHint),
        prefixIcon: widget.prefixIcon,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: textHint),
          borderRadius: BorderRadius.circular(12),
        ),
        border: OutlineInputBorder(
          borderSide:const BorderSide(color: textHint),
          borderRadius: BorderRadius.circular(12),
        ),
        suffixIcon: InkWell(
          onTap: _togglePasswordView,
          child: Icon(
            _isHidden ? Icons.visibility : Icons.visibility_off,
            color: textHint,
            size: 24,
          ),
        ),
      ),
      onChanged: (value) => widget.valueChanged != null ? widget.valueChanged!(value) : () => {},
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      obscureText: _isHidden,
      textInputAction: widget.inputAction,
      keyboardType: widget.keyboardType,
      inputFormatters: [
        if (widget.numberFormatters) FilteringTextInputFormatter.allow(RegExp('[0-9]')),
      ],
    );
  }
}
