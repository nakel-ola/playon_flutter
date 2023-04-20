import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'image_card.dart';

class DetailsAppBar extends StatelessWidget {
  final String imageUrl, type;
  final int id;
  const DetailsAppBar({
    super.key,
    required this.imageUrl,
    required this.type,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        style: IconButton.styleFrom(backgroundColor: Colors.white10),
        icon: const Icon(Iconsax.arrow_left),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: [
        IconButton(
          onPressed: () => Navigator.of(context).pushNamed("/search"),
          icon: const Icon(Iconsax.search_normal_1, color: Colors.white),
          style: IconButton.styleFrom(backgroundColor: Colors.white10),
        ),
        const SizedBox(width: 8.0),
      ],
      expandedHeight: 300.0,
      pinned: true,
      collapsedHeight: 60.0,
      flexibleSpace: FlexibleSpaceBar(
        background: ImageCard(
          id: id,
          imageUrl: imageUrl,
          type: type,
        ),
      ),
    );
  }
}
