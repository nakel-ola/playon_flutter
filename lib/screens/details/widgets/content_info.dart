import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ContentInfo extends StatefulWidget {
  final String title, releaseDate;
  final String? description;
  final double rating;

  const ContentInfo({
    super.key,
    required this.title,
    required this.releaseDate,
    required this.rating,
    this.description,
  });

  @override
  State<ContentInfo> createState() => _ContentInfoState();
}

class _ContentInfoState extends State<ContentInfo> {
  bool showAll = false;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        right: 8.0,
        top: 8.0,
        bottom: 8.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 10,
            child: Text(
              widget.title,
              style: const TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w500,
              ),
              // overflow: TextOve,
              softWrap: true,
            ),
          ),
          Row(
            children: [
              Icon(Iconsax.star5, size: 20.0, color: Colors.yellow.shade600),
              const SizedBox(width: 8.0),
              Text('${widget.rating} Rating'),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              const Icon(Iconsax.clock5, size: 20.0),
              const SizedBox(width: 8.0),
              Text(widget.releaseDate),
            ],
          ),
          const SizedBox(height: 8.0),
          if (widget.description != null)
            GestureDetector(
              onTap: () {
                setState(() {
                  showAll = !showAll;
                });
              },
              child: SizedBox(
                width: screenSize.width * 0.9,
                child: Text(
                  widget.description!,
                  style: TextStyle(fontSize: 14.0, color: Colors.grey.shade600),
                  overflow: TextOverflow.ellipsis,
                  maxLines: showAll ? 1000 : 2,
                ),
              ),
            )
        ],
      ),
    );
  }
}
