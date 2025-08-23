import 'package:flutter/cupertino.dart';

import 'link_card.dart';

class LinkList extends StatelessWidget {
  const LinkList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: const [
        LinkCard(
          title: 'The Future of AI in Healthcare',
          description:
              'Explore how artificial intelligence is revolutionizing healthcare, from diagnostics to treatment plans. This article delves into the latest advancements and their potential impact on patient care.',
          imageUrl:
              'https://lh3.googleusercontent.com/aida-public/AB6AXuBWAjvIORUwXClJse_LuRtK_eVRSY0cEVdrT1SsWu5P8kRFNmJXYmvucT7RgL54x1v5ylgeD_y_U1lZKRYYFt-TBBXCkkQQAGbiLIkEdOO7b0UHEyBRn4Lx5AWx6RgbWzMJ20O77hugHsZ4CCc60xBR5pZj_c4EpoDNYrsTlney93X4LqEqb4CPKOCt76a8nSu9RHmQcO4jeHNmjhMw2XkYvPVsQY10ZD89xNP0efk5HsYW4v1hAO2OWnAgvPXAy8F4aO2kStA7caY',
        ),
      ],
    );
  }
}
