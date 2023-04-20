import 'package:flutter/material.dart';

import '../../../utils/find_genre_by_ids.dart';

class GenreCard extends StatelessWidget {
  final List<dynamic> genreIds;
  final String type;

  const GenreCard({super.key, required this.genreIds, required this.type});

  @override
  Widget build(BuildContext context) {
    if (genreIds.isEmpty) return const SizedBox.shrink();
    final genres = findGenreByIds(genreIds);
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        right: 8.0,
        top: 8.0,
        bottom: 8.0,
      ),
      child: SizedBox(
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: genres
              .map(
                (e) => Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 28.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(e, style: const TextStyle(fontSize: 16.0)),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
