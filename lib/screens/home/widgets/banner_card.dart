import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../../../assets.dart';
import '../../../models/models.dart';
import '../../../providers/details_provider.dart';
import '../../../services/videos_service.dart';
import '../../../utils/find_genre_by_ids.dart';

class BannerCard extends StatelessWidget {
  final Video content;
  const BannerCard({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
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
            id: content.id,
            genreIds: content.genreIds ?? [],
            name: content.title ?? content.name ?? content.originalTitle ?? "",
            releaseDate: content.releaseDate ?? "",
            type: content.type,
            onDetailPressed: () {
              context.read<DetailsProvider>().addVideo(content);
              Navigator.of(context).pushNamed("/details");
            },
          ),
        ),
      ],
    );
  }
}

class TitleCard extends StatefulWidget {
  final List<dynamic> genreIds;
  final String name, releaseDate, type;
  final int id;
  final Function() onDetailPressed;

  const TitleCard({
    super.key,
    required this.genreIds,
    required this.name,
    required this.releaseDate,
    required this.type,
    required this.id,
    required this.onDetailPressed,
  });

  @override
  State<TitleCard> createState() => _TitleCardState();
}

class _TitleCardState extends State<TitleCard> {
  VideosService videosService = VideosService();
  List<Trailer> trailers = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    List<Trailer> items =
        await videosService.getTrailers(widget.type, widget.id);

    setState(() {
      trailers = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    final genres = findGenreByIds(widget.genreIds);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 10,
            child: Text(
              widget.name,
              style: const TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w500,
              ),
              // overflow: TextOve,
              softWrap: true,
            ),
          ),
          Text(widget.releaseDate),
          Text(genres.map((e) => e).join(" • ")),
          const SizedBox(height: 8.0),
          Row(
            children: [
              if (trailers.isNotEmpty)
                ElevatedButton.icon(
                  onPressed: () {
                    // Navigator.of(context).pushNamed(
                    //   "/video_player",
                    //   arguments: "${Assets.videoBaseUrl}?v=${trailers[0].key}",
                    // );
                  },
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
              if (trailers.isNotEmpty) const SizedBox(width: 8.0),
              if (trailers.isNotEmpty)
                Transform.rotate(
                  angle: 9.4,
                  child: IconButton(
                    onPressed: () => widget.onDetailPressed(),
                    icon: const Icon(
                      Iconsax.info_circle,
                      size: 30.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              if (trailers.isEmpty)
                ElevatedButton.icon(
                  onPressed: () => widget.onDetailPressed(),
                  icon: Transform.rotate(
                    angle: 9.4,
                    child: const Icon(Iconsax.info_circle5, size: 30.0),
                  ),
                  label: const Text(
                    "See details",
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
                )
            ],
          ),
        ],
      ),
    );
  }
}
