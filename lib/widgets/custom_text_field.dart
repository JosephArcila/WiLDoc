import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? errorText;
  final bool obscureText;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.errorText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final errorColor = theme.colorScheme.error;
    final onErrorColor = theme.colorScheme.onSurface;

    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
        errorText: errorText,
        errorMaxLines: 2,
        errorStyle: TextStyle(color: errorColor),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorColor),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorColor),
        ),
        labelStyle: TextStyle(color: errorText != null ? errorColor : null),
      ),
      style: TextStyle(color: onErrorColor),
      cursorColor: errorColor,
    );
  }
}
