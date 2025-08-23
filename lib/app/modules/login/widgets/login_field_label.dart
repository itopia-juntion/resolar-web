import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class LoginFieldLabel extends StatelessWidget {
  final String text;
  const LoginFieldLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        height: 1.0,
      ),
    );
  }
}
