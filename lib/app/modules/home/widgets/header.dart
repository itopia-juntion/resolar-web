import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resolar_web/app/modules/home/controllers/home_controller.dart';
import 'package:resolar_web/app/widgets/app_input.dart';

import '../../../core/constants/app_colors.dart';

class Header extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        Obx(
          () => Text(
            Get.find<HomeController>().selectedSubject?.name ?? '',
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.w800),
          ),
        ),
        Expanded(child: SizedBox()),
        SizedBox(
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
              AppInput(controller: controller),
            ],
          ),
        ),
      ],
    );
  }
}
