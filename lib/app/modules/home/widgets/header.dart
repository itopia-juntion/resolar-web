import 'package:flutter/material.dart';

import '../../../core/constants/app_color.dart';

class Header extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        const Text(
          'All Links',
          style: TextStyle(fontSize: 34, fontWeight: FontWeight.w800),
        ),
        Expanded(child: SizedBox()),
        SizedBox(
          width: 360,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              const Positioned(
                left: 12,
                child: Icon(
                  Icons.search,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
              ),
              TextField(
                controller: controller,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Search links...',
                  hintStyle: const TextStyle(color: Color(0xFF6B7280)),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  filled: true,
                  fillColor: AppColors.sidebarBg,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.accent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
