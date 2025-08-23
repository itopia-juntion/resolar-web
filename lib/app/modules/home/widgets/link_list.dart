import 'package:flutter/cupertino.dart';
import 'package:resolar_web/app/models/web_page.dart';

import 'link_card.dart';

class LinkList extends StatelessWidget {
  final List<WebPage> pages;
  const LinkList({super.key, required this.pages});

  @override
  Widget build(BuildContext context) {
    if (pages.isEmpty) {
      return const Center(child: Text('No pages found in this topic yet.'));
    }

    return ListView.builder(
      itemCount: pages.length,
      itemBuilder: (context, index) {
        final page = pages[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: LinkCard(
            title: page.url, // No title field, using url instead
            description: page.summary,
            // No imageUrl field in WebPage model
            imageUrl: '',
          ),
        );
      },
    );
  }
}
