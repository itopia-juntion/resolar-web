import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resolar_web/app/modules/home/controllers/home_controller.dart';
import 'package:resolar_web/app/widgets/adaptive_wrap.dart';
import 'package:resolar_web/app/widgets/app_input.dart';

import '../../../core/constants/app_colors.dart';

class Header extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  Header({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveWrap(
      /*spacing: 16, // 가로 간격
      runSpacing: 12, // 줄 바뀔 때 세로 간격
      crossAxisAlignment: WrapCrossAlignment.center,*/
      children: [
        Obx(
          () => Text(
            controller.selectedSubject?.name ?? '',
            style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w800),
          ),
        ),
        SizedBox(
          // Expanded 대신 Wrap에서는 SizedBox로 폭 제한
          width: 360,
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}
