import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

class LoginInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;

  const LoginInput({
    super.key,
    required this.controller,
    required this.hint,
    this.obscure = false,
    this.keyboardType,
    this.autofillHints,
    this.validator,
    this.focusNode,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      autofillHints: autofillHints,
      style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
      validator: validator,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: onFieldSubmitted != null
          ? TextInputAction.next
          : TextInputAction.done,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textSecondary),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.border),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.brandPrimary, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.redAccent),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
