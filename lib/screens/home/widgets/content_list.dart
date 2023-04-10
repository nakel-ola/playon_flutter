import 'package:flutter/material.dart';

import '../../../models/models.dart';
import '../../../widgets/widgets.dart';
import 'content_card.dart';

class ContentList extends StatelessWidget {
  final String title;
  final List<Video> items;
  const ContentList({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SizedBox(
      height: 400,
      width: screenSize.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Text(
              title,
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 350.0,
            child: ScrollCard(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(width: 16.0),
                  ...items
                      .map(
                        (e) => ContentCard(
                          key: ValueKey(e.id),
                          content: e,
                        ),
                      )
                      .toList(),
                  const SizedBox(width: 16.0),
                ],
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
