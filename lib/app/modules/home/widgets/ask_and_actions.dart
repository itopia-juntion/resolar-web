import 'package:flutter/material.dart';

import '../../../core/constants/app_color.dart';
import 'action_button.dart';

class AskAndActions extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  AskAndActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        // Ask AI input + send
        Expanded(
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              TextField(
                controller: controller,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Ask AI about these links and summaries...',
                  hintStyle: const TextStyle(color: Color(0xFF6B7280)),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                  filled: true,
                  fillColor: AppColors.sidebarBg,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.accent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onSubmitted: (_) {},
              ),
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: IconButton.filled(
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: const CircleBorder(),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.send_rounded, size: 18),
                  tooltip: 'Send',
                ),
              ),
            ],
          ),
        ),

        // Actions
        ActionButton(
          icon: Icons.picture_as_pdf_rounded,
          label: 'Save as PDF',
          onTap: () {},
        ),
        ActionButton(
          icon: Icons.description_rounded,
          label: 'Save to Docs',
          onTap: () {},
        ),
      ],
    );
  }
}
