import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class TopicItem extends StatelessWidget {
  final String label;
  final bool active;
  final void Function() onTap;
  final void Function() onDelete;

  const TopicItem({
    super.key,
    required this.label,
    this.active = false,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final bg = active ? AppColors.primary : Colors.transparent;
    final fg = active ? Colors.white : AppColors.textSecondary;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: fg,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete, color: fg.withAlpha(120), size: 16),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
