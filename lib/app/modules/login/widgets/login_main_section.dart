import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resolar_web/app/modules/login/controllers/login_controller.dart';

import '../../../core/constants/app_colors.dart';
import '../../../widgets/glass_card.dart';
import '../../../widgets/hover_scale.dart';
import '../../../widgets/login_input.dart';
import 'login_field_label.dart';

class LoginMainSection extends StatelessWidget {
  LoginController get controller => Get.find<LoginController>();

  const LoginMainSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 480),
      child: GlassCard(
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Column(
                  children: [
                    Obx(
                      () => Text(
                        controller.isSignUp ? 'Sign up' : 'Login',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Welcome to Resolar',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // ID
              const LoginFieldLabel('ID'),
              const SizedBox(height: 8),
              LoginInput(
                controller: controller.username,
                hint: 'username',
                autofillHints: const [AutofillHints.username],
              ),
              const SizedBox(height: 16),

              // Password + forgot
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const LoginFieldLabel('Password'),
                  Obx(
                    () => Visibility(
                      visible: !controller.isSignUp,
                      replacement: SizedBox(),
                      child: TextButton(
                        onPressed: () {},
                        style: _linkStyle(),
                        child: const Text('Forgot password?'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LoginInput(
                controller: controller.password,
                hint: '••••••••',
                obscure: true,
                autofillHints: const [AutofillHints.password],
                validator: (v) => (v == null || v.isEmpty)
                    ? 'Please enter your password.'
                    : null,
              ),
              const SizedBox(height: 16),

              // Email
              Obx(() {
                if (!controller.isSignUp) return SizedBox();
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const LoginFieldLabel('Email'),
                    const SizedBox(height: 8),
                    LoginInput(
                      controller: controller.email,
                      hint: 'mymail@mail.com',
                    ),
                  ],
                );
              }),
              const SizedBox(height: 20),

              // Submit
              HoverScale(
                child: SizedBox(
                  height: 48,
                  child: FilledButton(
                    onPressed: controller.loggingIn
                        ? null
                        : controller.onSubmit,
                    style: ButtonStyle(
                      elevation: const MaterialStatePropertyAll(2),
                      backgroundColor: MaterialStateProperty.resolveWith(
                        (s) =>
                            s.contains(MaterialState.hovered) ||
                                s.contains(MaterialState.pressed)
                            ? AppColors.brandSecondary
                            : AppColors.brandPrimary,
                      ),
                      foregroundColor: const MaterialStatePropertyAll(
                        Colors.white,
                      ),
                      overlayColor: const MaterialStatePropertyAll(
                        Colors.white24,
                      ),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: Obx(
                      () => controller.loggingIn
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation(
                                  Colors.white,
                                ),
                              ),
                            )
                          : Obx(
                              () => Text(
                                controller.isSignUp ? 'Sign Up' : 'Log In',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                    ),
                  ),
                ),
              ),

              // Footer
              const SizedBox(height: 24),
              Obx(
                () => Visibility(
                  visible: !controller.isSignUp,
                  replacement: SizedBox(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Not a member? ',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                      TextButton(
                        onPressed: () {
                          controller.toggleSignUp();
                        },
                        style: _linkStyle(),
                        child: const Text('Sign up for free'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ButtonStyle _linkStyle() {
    return ButtonStyle(
      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
      minimumSize: const WidgetStatePropertyAll(Size(0, 0)),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      foregroundColor: MaterialStateProperty.resolveWith(
        (states) => states.contains(MaterialState.hovered)
            ? AppColors.brandSecondary
            : AppColors.brandPrimary,
      ),
      textStyle: const WidgetStatePropertyAll(
        TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}
