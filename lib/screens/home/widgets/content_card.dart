import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../assets.dart';
import '../../../models/models.dart';

class ContentCard extends StatelessWidget {
  final Video content;
  const ContentCard({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    final String imageUrl =
        "${Assets.imageBaseUrl}${content.backdropPath ?? content.posterPath}";

    final String name =
        "${content.title ?? content.name ?? content.originalTitle}";

    final Color color =
        Assets.colors[Random().nextInt(Assets.colors.length - 1)];

    const double height = 180.0, width = 300.0;
    const EdgeInsetsGeometry margin = EdgeInsets.only(right: 16.0);
    final BorderRadiusGeometry borderRadius = BorderRadius.circular(10.0);

    final double rating =
        content.voteAverage == null ? 0.0 : content.voteAverage! / 2;

    return SizedBox(
      width: 300.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            imageBuilder: (_, image) => Container(
              height: height,
              width: width,
              margin: margin,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                image: DecorationImage(image: image, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => Container(
              height: height,
              width: width,
              margin: margin,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: color,
              ),
              child: const Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (_, url, error) => Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: color,
              ),
              margin: margin,
            ),
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            width: 280.0,
            child: Text(
              name,
              style:
                  const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: [
              Icon(Iconsax.star5, size: 30.0, color: Colors.yellow.shade600),
              const SizedBox(width: 8.0),
              Text('$rating Rating'),
            ],
          ),
          const SizedBox(height: 8.0),
          if (content.description != null)
            SizedBox(
              width: 280.0,
              child: Text(
                content.description!,
                style: TextStyle(fontSize: 14.0, color: Colors.grey.shade600),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            )
        ],
      ),
    );
  }
}
