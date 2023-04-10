import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../../models/models.dart';
import 'content_list.dart';

class CategoryCard extends StatelessWidget {
  final String name, url;
  const CategoryCard({super.key, required this.name, required this.url});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: FutureBuilder(
        future: _fetchData(url),
        initialData: null,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final results = (snapshot.data["results"] as List<dynamic>)
                .map(
                  (e) => Video(
                    adult: e["adult"],
                    backdropPath: e["backdrop_path"],
                    description: e["overview"],
                    genreIds: e["genre_ids"],
                    id: e["id"],
                    name: e["name"],
                    originalLanguage: e["original_language"],
                    originalTitle: e["original_title"],
                    overview: e["overview"],
                    popularity: e["popularity"],
                    posterPath: e["poster_path"],
                    releaseDate: e["release_date"],
                    title: e["title"],
                    type: "movie",
                    video: e["video"],
                    voteAverage: e["vote_average"],
                    voteCount: e["vote_count"],
                  ),
                )
                .toList();

            // final items = ApiResponse(
            //   page: snapshot.data["page"],
            //   results: results,
            //   totalPages: snapshot.data["total_pages"],
            //   totalResults: snapshot.data["total_results"],
            // );
            return ContentList(title: name, items: results);
          }
          return const SizedBox();
        },
      ),
    );
  }

  Future<T> _fetchData<T>(String url) async {
    try {
      final res = await http.get(Uri.parse(url));
      var jsonResponse = convert.jsonDecode(res.body);

      return jsonResponse;
    } catch (e) {
      rethrow;
    }
  }
}
