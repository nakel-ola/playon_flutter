import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../models/models.dart';
import '../../../services/videos_service.dart';

class ImageCard extends StatefulWidget {
  final String imageUrl, type;
  final int id;
  const ImageCard({
    super.key,
    required this.imageUrl,
    required this.type,
    required this.id,
  });

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
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
    return Stack(
      children: [
        SizedBox(
          height: 300,
          width: double.infinity,
          child: CachedNetworkImage(
            imageUrl: widget.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        if (trailers.isNotEmpty)
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black26,
                  ],
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  // Navigator.of(context).pushNamed(
                  //   "/video_player",
                  //   arguments: "${Assets.videoBaseUrl}?v=${trailers[0].key}",
                  // );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Iconsax.play_circle5, size: 60.0),
                    Text(
                      "Play trailer",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
          )
      ],
    );
  }
}
