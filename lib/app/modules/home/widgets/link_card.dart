import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../core/constants/app_colors.dart';

class LinkCard extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String url;

  const LinkCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.url,
  });

  @override
  State<LinkCard> createState() => _LinkCardState();
}

class _LinkCardState extends State<LinkCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchUrlString(widget.url),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hover ? AppColors.primary : AppColors.accent,
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Texts
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.description,
                      style: const TextStyle(
                        fontSize: 13.5,
                        height: 1.5,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              // Thumbnail
              /*              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.imageUrl,
                  width: 160,
                  height: 96,
                  fit: BoxFit.cover,
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
