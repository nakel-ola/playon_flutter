import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../assets.dart';
import '../../providers/details_provider.dart';
import 'widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final video = context.read<DetailsProvider>().video;

    if (video == null) return const SizedBox.shrink();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          DetailsAppBar(
            imageUrl: "${Assets.imageBaseUrl}${video.backdropPath}",
            id: video.id,
            type: video.type,
          ),
          SliverToBoxAdapter(
            child: ContentInfo(
              title: video.title ?? video.name ?? video.originalTitle ?? "",
              releaseDate: video.releaseDate ?? "",
              rating: video.voteAverage == null ? 0.0 : video.voteAverage! / 2,
              description: video.description,
            ),
          ),
          SliverToBoxAdapter(
            child: GenreCard(genreIds: video.genreIds ?? [], type: video.type),
          ),
          SliverToBoxAdapter(child: Casts(id: video.id)),
          if (video.type == "tv")
            SliverToBoxAdapter(child: Seasons(id: video.id)),
          SliverToBoxAdapter(child: Reviews(id: video.id, type: video.type)),
          SliverToBoxAdapter(
            child: Recommended(id: video.id, type: video.type),
          ),
          SliverToBoxAdapter(child: Similar(id: video.id, type: video.type)),
        ],
      ),
      // extendBodyBehindAppBar: true,
    );
  }
}
