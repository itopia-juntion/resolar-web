import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resolar_web/app/routes/app_pages.dart';
import 'package:resolar_web/app/services/auth_service.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authService = Get.find<AuthService>();
    if (!authService.isLoggedIn()) {
      return const RouteSettings(name: Routes.LOGIN);
    }
    return null;
  }
}
