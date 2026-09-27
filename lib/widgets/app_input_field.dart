import 'package:flutter/material.dart';

/// Rounded, borderless input field used on Login and the Form Page.
/// Owns no state - the caller supplies and owns the TextEditingController.
class AppInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final int maxLines;

  const AppInputField({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
