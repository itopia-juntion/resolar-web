import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resolar_web/app/modules/home/controllers/home_controller.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../core/constants/app_colors.dart';
import 'action_button.dart';

class AskAndActions extends StatelessWidget {
  HomeController get controller => Get.find<HomeController>();

  const AskAndActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Ask AI input + send
        Expanded(
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              TextField(
                controller: controller.askController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Ask AI what you want...',
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
                onSubmitted: (_) {
                  controller.searchAiPages();
                },
              ),
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: IconButton.filled(
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: const CircleBorder(),
                  ),
                  onPressed: () {
                    controller.searchAiPages();
                  },
                  icon: const Icon(Icons.send_rounded, size: 18),
                  tooltip: 'Send',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        // Actions
        Obx(() {
          var btn = ActionButton(
            icon: Icons.picture_as_pdf_rounded,
            label: 'Save as PDF',
            onTap: () {
              if (!controller.isGeneratingPdf) {
                controller.generateAndDownloadPdf();
              }
            },
          );

          if (controller.isGeneratingPdf) {
            return Shimmer(child: btn);
          }
          return btn;
        }),
      ],
    );
  }
}
