import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../../main.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/home_controller.dart';
import '../widgets/ask_and_actions.dart';
import '../widgets/header.dart';
import '../widgets/link_list.dart';
import '../widgets/sidebar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final isWide = c.maxWidth >= 1000;
        final sidebar = const Sidebar();

        if (isWide) {
          return Scaffold(
            body: Row(
              children: [
                SizedBox(width: 320, child: sidebar), // w-80
                const VerticalDivider(
                  width: 1,
                  thickness: 1,
                  color: AppColors.accent,
                ),
                const Expanded(child: _MainArea()),
              ],
            ),
          );
        } else {
          return Scaffold(
            drawer: Drawer(
              backgroundColor: AppColors.sidebarBg,
              child: SafeArea(child: sidebar),
            ),
            appBar: AppBar(
              backgroundColor: AppColors.background,
              elevation: 0,
              title: const Text(
                appName,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              actions: [],
            ),
            body: const _MainArea(),
          );
        }
      },
    );
  }
}

class _MainArea extends StatelessWidget {
  const _MainArea();

  HomeController get controller => Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScrollConfiguration(
        behavior: const _NoGlow(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Obx(() {
                      if (controller.isAiSearchMode) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: TextButton.icon(
                                onPressed: controller.clearAiSearch,
                                icon: const Icon(Icons.arrow_back, size: 18),
                                label: const Text('Back to list'),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white70,
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: LinkList(pages: controller.aiSearchPages),
                            ),
                          ],
                        );
                      } else {
                        return LinkList(pages: controller.pages);
                      }
                    }),
                  ),
                  const SizedBox(height: 24),
                  const Divider(color: AppColors.accent, height: 1),
                  const SizedBox(height: 24),
                  Obx(() {
                    var loading = controller.isLoading;
                    var widget = AskAndActions();

                    if (loading) return Shimmer(child: widget);
                    return widget;
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NoGlow extends ScrollBehavior {
  const _NoGlow();
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
