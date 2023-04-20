import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../assets.dart';
import '../../../services/videos_service.dart';
import '../../../widgets/widgets.dart';

class Casts extends StatelessWidget {
  final dynamic id;
  const Casts({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    VideosService services = VideosService();

    Widget imagePlaceholder = const SizedBox(
      width: 120,
      height: 120,
      child: CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(Iconsax.user, size: 60),
      ),
    );

    Widget wrapper({required Widget child}) {
      return Padding(
        padding: const EdgeInsets.only(
            left: 12.0, right: 8.0, top: 8.0, bottom: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Casts",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            child
          ],
        ),
      );
    }

    return RequestBuilder(
      future: () async => await services.getCast(id),
      builder: (context, snapshot) {
        bool isLoading = snapshot.connectionState == ConnectionState.waiting;

        if (isLoading) {
          return wrapper(
            child: const SizedBox(
              height: 100,
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        if (snapshot.data == null) {
          return const SizedBox.shrink();
        }

        return wrapper(
          child: SizedBox(
            height: 180.0,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: snapshot.data!
                  .map(
                    (e) => Container(
                      width: 150,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          CachedNetworkImage(
                            imageUrl: "${Assets.imageBaseUrl}${e.profilePath}",
                            imageBuilder: (_, image) => SizedBox(
                              width: 120,
                              height: 120,
                              child: CircleAvatar(
                                backgroundImage: image,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            placeholder: (_, url) => imagePlaceholder,
                            errorWidget: (_, url, error) => imagePlaceholder,
                            // fit: BoxFit.cover,
                          ),
                          Text(
                            e.name ?? e.orignalName ?? "",
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            e.character ?? "",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
