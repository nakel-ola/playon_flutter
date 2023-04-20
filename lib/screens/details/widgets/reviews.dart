import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:iconsax/iconsax.dart';

import '../../../models/models.dart';
import '../../../services/videos_service.dart';
import '../../../widgets/widgets.dart';

class Reviews extends StatelessWidget {
  final dynamic id;
  final String type;
  const Reviews({super.key, required this.id, required this.type});

  @override
  Widget build(BuildContext context) {
    VideosService services = VideosService();

    Widget wrapper({required Widget child, bool show = false}) {
      return Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 8.0, top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Reviews",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (show)
                  const Text("See more", style: TextStyle(color: Colors.blue))
              ],
            ),
            child
          ],
        ),
      );
    }

    return RequestBuilder(
      future: () async => await services.getReviews(id: id, type: type),
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

        if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        }

        if (snapshot.data!.isEmpty) {
          return wrapper(
            child: const SizedBox(
              height: 50,
              child: Center(
                  child: Text(
                "There are no reviews yet",
                style: TextStyle(fontSize: 18.0),
              )),
            ),
          );
        }

        return wrapper(
          show: snapshot.data!.length > 5,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: snapshot.data!
                  .take(5)
                  .map((e) => ReviewCard(content: e))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}

class ReviewCard extends StatefulWidget {
  final Review content;
  const ReviewCard({super.key, required this.content});

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  bool showAll = false;
  @override
  Widget build(BuildContext context) {
    final String name = widget.content.authorDetails.username ??
        widget.content.authorDetails.name ??
        "";
    Widget imagePlaceholder = const SizedBox(
      width: 50,
      height: 50,
      child: CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(Iconsax.user, size: 30),
      ),
    );

    Widget headerWidget = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 18.0),
        ),
        Text(
          "4 days ago",
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        )
      ],
    );

    parseUrl(String url) {
      if (url.startsWith('/')) {
        return url.substring(1);
      } else {
        return url;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: parseUrl("${widget.content.authorDetails.avatarPath}"),
            imageBuilder: (_, image) => SizedBox(
              height: 50,
              width: 50,
              child: CircleAvatar(
                backgroundImage: image,
                backgroundColor: Colors.transparent,
              ),
            ),
            placeholder: (_, url) => imagePlaceholder,
            errorWidget: (_, url, error) => imagePlaceholder,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  headerWidget,
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showAll = !showAll;
                      });
                    },
                    child: Text(
                      widget.content.content,
                      overflow: TextOverflow.ellipsis,
                      maxLines: showAll ? 1000 : 4,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
