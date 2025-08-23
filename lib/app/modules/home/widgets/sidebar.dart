import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resolar_web/app/models/subject.dart';
import 'package:resolar_web/app/modules/home/controllers/home_controller.dart';

import '../../../core/constants/app_colors.dart';
import '../../../widgets/app_banner.dart';
import '../../../widgets/login_input.dart';
import '../models/topic_item.dart';

class Sidebar extends StatelessWidget {
  HomeController get controller => Get.find<HomeController>();

  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.sidebarBg,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBanner(),
                const SizedBox(height: 32),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'TOPICS',
                    style: TextStyle(
                      color: AppColors.textSecondary.withOpacity(0.9),
                      fontSize: 12,
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Obx(() {
                    List<Subject> subjects = controller.subjectList;

                    if (subjects.isEmpty) {
                      return Text('No subject yet!');
                    }

                    return ListView.builder(
                      itemCount: subjects.length,
                      itemBuilder: (_, i) {
                        Subject sub = subjects[i];
                        return Obx(
                          () => TopicItem(
                            label: sub.name,
                            onTap: () {
                              controller.selectSubject(sub);
                            },
                            onDelete: () => controller.deleteSubject(sub),
                            active: controller.selectedSubject == sub,
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),

          // Bottom
          Column(
            children: [
              LoginInput(
                controller: controller.newTopicController,
                hint: 'Stock',
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: Obx(
                  () => FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: controller.isTopicNameValid
                        ? controller.createNewTopic
                        : null,
                    icon: const Icon(Icons.add, size: 20),
                    label: const Text(
                      'New Topic',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
