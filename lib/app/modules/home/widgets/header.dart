import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resolar_web/app/modules/home/controllers/home_controller.dart';
import 'package:resolar_web/app/widgets/app_input.dart';

import '../../../core/constants/app_colors.dart';

class Header extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Text(
            controller.selectedSubject?.name ?? '',
            style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w800),
          ),
        ),
        const Expanded(child: SizedBox()),
        SizedBox(
          width: 360,
          child: Row(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    const Positioned(
                      left: 12,
                      child: Icon(
                        Icons.search,
                        size: 20,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    AppInput(
                      controller: controller.searchController,
                      hint: 'Search links...',
                      onSubmitted: (_) => controller.searchPages(),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: controller.searchPages,
                icon: const Icon(Icons.search),
                tooltip: 'Search',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
