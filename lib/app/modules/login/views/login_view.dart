import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resolar_web/app/modules/login/widgets/login_main_section.dart';

import '../../../core/constants/app_colors.dart';
import '../../../widgets/app_banner.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 배경 그라데이션
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.backgroundStart, AppColors.backgroundEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              LayoutBuilder(
                builder: (context, c) {
                  final wide = c.maxWidth >= 768.0;
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: wide ? 40 : 24, // md:px-10 / px-6
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        // Brand
                        AppBanner(),
                        const Spacer(),
                      ],
                    ),
                  );
                },
              ),

              // Main
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: LoginMainSection(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
