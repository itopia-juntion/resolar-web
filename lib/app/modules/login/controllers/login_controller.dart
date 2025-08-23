import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:resolar_web/app/api_client.dart';
import 'package:resolar_web/app/core/utils/app_utils.dart';
import 'package:resolar_web/app/routes/app_pages.dart';
import 'package:resolar_web/app/services/auth_service.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final RxBool _loggingIn = RxBool(false);
  final RxBool _isSignUp = RxBool(false);

  bool get loggingIn => _loggingIn.value;
  bool get isSignUp => _isSignUp.value;

  @override
  void onInit() {
    super.onInit();
    final authService = Get.find<AuthService>();
    username.text = authService.username ?? '';
    password.text = authService.password ?? '';
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
      if (isSignUp) {
        await _signUp();
      } else {
        await _login();
      }
    } catch (e) {
      AppUtils.showSnackBar('There was an error while login or Sign up');
      if (kDebugMode) rethrow;
    } finally {
      _loggingIn.value = false;
    }
  }

  Future<void> _signUp() async {
    var as = Get.find<AuthService>();
    var result = await as.signUp(
      username.text.trim(),
      password.text.trim(),
      email.text.trim(),
    );

    if (result is RequestSuccess) {
      Get.offAllNamed(Routes.HOME);
    } else {
      AppUtils.showSnackBar('Sorry. Your email or id already exists!');
    }
  }

  Future<void> _login() async {
    var as = Get.find<AuthService>();
    var result = await as.login(username.text.trim(), password.text.trim());

    if (result is RequestSuccess) {
      Get.offAllNamed(Routes.HOME);
    } else {
      AppUtils.showSnackBar('Sorry. Please check your id or password!');
    }
  }

  void toggleSignUp() {
    _isSignUp.value = !_isSignUp.value;
  }
}
