import 'package:flutter/material.dart';

import '../../models/models.dart';
import 'widgets/widgets.dart';

class HomeContainer extends StatelessWidget {
  final List<ResponseItem> items;

  const HomeContainer({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(height: 900),
            BannerCard(content: items[0].results[0]),
            Positioned(
              bottom: -20.0,
              child: ContentList(
                key: ValueKey(items[0].name),
                items: items[0].results,
                title: items[0].name,
              ),
            ),
          ],
        ),
        ...items
            .skip(1)
            .map(
              (e) => ContentList(
                key: ValueKey(e.name),
                items: e.results,
                title: e.name,
              ),
            )
            .toList(),
        const SizedBox(height: 100)
      ],
    );
  }
}
