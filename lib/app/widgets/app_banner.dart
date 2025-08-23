import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resolar_web/app/routes/app_pages.dart';

import '../../gen/assets.gen.dart';
import '../../main.dart';
import '../core/constants/app_colors.dart';

class AppBanner extends StatelessWidget {
  const AppBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //behavior: HitTestBehavior.translucent,
      onTap: () {
        if (Get.currentRoute == AppPages.INITIAL) return;
        Get.offAllNamed(AppPages.INITIAL);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.images.appLogo.image(
            //color: Colors.white,
            scale: 24,
          ),
          SizedBox(width: 8),
          Text(
            appName,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
