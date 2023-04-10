import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../assets.dart';
import '../../../models/video.dart';

class BannerCard extends StatelessWidget {
  final Video content;
  const BannerCard({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    print(content.toJson());

    return Stack(
      children: [
        SizedBox(
          height: 600,
          width: double.infinity,
          child: CachedNetworkImage(
            imageUrl: "${Assets.imageBaseUrl}${content.backdropPath}",
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: 600,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black,
                Colors.transparent,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          child: TitleCard(
            genreIds: content.genreIds ?? [],
            name: content.title ?? content.name ?? content.originalTitle ?? "",
            releaseDate: content.releaseDate ?? "",
          ),
        ),
      ],
    );
  }
}

class TitleCard extends StatelessWidget {
  final List<dynamic> genreIds;
  final String name, releaseDate;

  const TitleCard({
    super.key,
    required this.genreIds,
    required this.name,
    required this.releaseDate,
  });

  List<String> _getGenres() {
    if (genreIds.isEmpty) return [];

    final List<dynamic> ids = genreIds.take(3).toList();

    final List<String> results = [];

    for (var i = 0; i < ids.length; i++) {
      final genre = Assets.genres.firstWhere((el) => el.id == ids[i]);
      results.add(genre.name);
    }

    return results;
  }

  @override
  Widget build(BuildContext context) {
    final genres = _getGenres();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 10,
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w500,
              ),
              // overflow: TextOve,
              softWrap: true,
            ),
          ),
          Text(releaseDate),
          Text(genres.map((e) => e).join(" • ")),
          const SizedBox(height: 8.0),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Iconsax.play5, size: 30.0),
                label: const Text(
                  "Watch trailer",
                  style: TextStyle(fontSize: 16.0),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 12.0,
                  ),
                  elevation: 2.0,
                ),
              ),
              const SizedBox(width: 8.0),
              Transform.rotate(
                angle: 9.4,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Iconsax.info_circle,
                    size: 30.0,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
