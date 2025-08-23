import 'package:flutter/material.dart';
import 'package:resolar_web/gen/assets.gen.dart';

import '../../../core/constants/app_color.dart';
import '../models/topic_item.dart';

class Sidebar extends StatelessWidget {
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
          Column(
            children: [
              Row(
                children: [
                  Assets.images.appLogo.image(scale: 28),
                  SizedBox(width: 8),
                  Text(
                    'Resolar',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
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
              const TopicItem(label: 'Science', active: true),
              const TopicItem(label: 'Product Design'),
              const TopicItem(label: 'UX Research'),
              const TopicItem(label: 'Marketing Strategy'),
              const TopicItem(label: 'AI Integration'),
            ],
          ),

          // Bottom
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 44,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.add, size: 20),
                  label: const Text(
                    'New Topic',
                    style: TextStyle(fontWeight: FontWeight.w700),
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
