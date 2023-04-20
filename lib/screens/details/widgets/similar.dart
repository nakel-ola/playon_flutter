import 'package:flutter/material.dart';

import '../../../services/videos_service.dart';
import '../../../widgets/widgets.dart';
import '../../home/widgets/content_list.dart';

class Similar extends StatelessWidget {
  final dynamic id;
  final String type;
  const Similar({super.key, this.id, required this.type});

  @override
  Widget build(BuildContext context) {
    VideosService services = VideosService();

    final String title = "Similar ${type == "movie" ? "Movies" : "Series"}";

    Widget loader = Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 8.0, top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 100,
            child: Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );

    return RequestBuilder(
      future: () async => await services.getSimilarVideos(id, type),
      builder: (_, snapshot) {
        bool isLoading = snapshot.connectionState == ConnectionState.waiting;

        if (isLoading) return loader;

        if (snapshot.data == null) {
          return const SizedBox.shrink();
        }

        return ContentList(
          items: snapshot.data!.results,
          title: title,
        );
      },
    );
  }
}
