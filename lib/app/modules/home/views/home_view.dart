import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_color.dart';
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
                'Resolar',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  tooltip: 'New Topic',
                ),
              ],
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScrollConfiguration(
        behavior: const _NoGlow(),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(),
                  const SizedBox(height: 8),
                  Expanded(
                    child: SingleChildScrollView(child: const LinkList()),
                  ),
                  const SizedBox(height: 24),
                  const Divider(color: AppColors.accent, height: 1),
                  const SizedBox(height: 24),
                  AskAndActions(),
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
