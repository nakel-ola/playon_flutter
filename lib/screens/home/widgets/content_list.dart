import 'package:flutter/material.dart';

import '../../../models/models.dart';
import '../../../widgets/widgets.dart';
import 'content_card.dart';

class ContentList extends StatelessWidget {
  final String title;
  final List<Video> items;
  final bool showMore;
  final Function()? onSeeMoreTap;
  const ContentList({
    super.key,
    required this.title,
    required this.items,
    this.showMore = false,
    this.onSeeMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    if (items.isEmpty) return const SizedBox.shrink();

    final List<Video> newItems = [
      const Video(id: 0, type: ""),
      ...items,
      const Video(id: 2, type: ""),
    ];

    return Container(
      width: screenSize.width,
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 24.0, fontWeight: FontWeight.w500),
                ),
                if (showMore)
                  TextButton(
                    onPressed: onSeeMoreTap,
                    child: const Text("See more",
                        style: TextStyle(color: Colors.blue)),
                  ),
              ],
            ),
          ),
          SizedBox(
            height: 300.0,
            child: ScrollCard(
              child: SizedBox(
                height: 300.0,
                child: ListView.builder(
                  itemCount: newItems.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    if (index == 0 || index == newItems.length) {
                      return const SizedBox(width: 16.0);
                    }
                    return Row(
                      children: [
                        ContentCard(content: items[index]),
                        const SizedBox(width: 16.0)
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
