import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:resolar_web/app/api_client.dart';
import 'package:resolar_web/app/core/utils/app_utils.dart';
import 'package:resolar_web/app/routes/app_pages.dart';
import 'package:resolar_web/app/services/auth_service.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();
  final RxBool _loggingIn = RxBool(false);

  bool get loggingIn => _loggingIn.value;

  @override
  void onInit() async {
    super.onInit();
    var as = Get.find<AuthService>();
    RequestResult res1 = await as.login('testuser', 'password1232');
    RequestResult res2 = await as.login('testuser', 'password123');

    if (res1 is RequestFail) {
      log("성공!0 ");
    }

    if (res2 is RequestSuccess) {
      log("성공!");
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    username.dispose();
    password.dispose();
    super.onClose();
  }

  Future<void> onSubmit() async {
    if (!formKey.currentState!.validate()) return;
    _loggingIn.value = true;

    try {
      var as = Get.find<AuthService>();
      var result = await as.login(username.text.trim(), password.text.trim());

      if (result is RequestSuccess) {
        Get.offAllNamed(Routes.HOME);
      } else {
        AppUtils.showSnackBar('Sorry. Please check your id or password!');
      }
    } catch (e) {
      AppUtils.showSnackBar('There was an error while login');
      if (kDebugMode) rethrow;
    } finally {
      _loggingIn.value = false;
    }
  }
}
