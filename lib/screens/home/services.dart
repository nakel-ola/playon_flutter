import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../assets.dart';
import '../../models/models.dart';

class Services {
  Future<T> _fetchData<T>(String url) async {
    try {
      final res = await Dio().get(url);

      return res.data;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<ApiResponse> fetchCategory(String url, String type) async {
    final data = await _fetchData(url);

    final results = (data["results"] as List<dynamic>)
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
            type: type,
            video: e["video"],
            voteAverage: e["vote_average"],
            voteCount: e["vote_count"],
          ),
        )
        .toList();

    return ApiResponse(
      page: data["page"],
      results: results,
      totalPages: data["total_pages"],
      totalResults: data["total_results"],
    );
  }

  Future<List<ResponseItem>> getData({
    required String type,
    bool shuffle = true,
    int page = 1,
  }) async {
    final List<Recommendation> items = type == "Home"
        ? Assets.recommendations
        : type == "Movies"
            ? Assets.movies
            : Assets.series;

    final List<ResponseItem> results = [];

    final String newType = type == "Home"
        ? "movies"
        : type == "Movies"
            ? "movies"
            : "series";

    for (var i = 0; i < items.length; i++) {
      final data = await fetchCategory(items[i].url, newType);

      results.add(
        ResponseItem(
          name: items[i].name,
          page: data.page,
          results: data.results,
          totalPages: data.totalPages,
          totalResults: data.totalResults,
        ),
      );
    }

    return results;

    // if (type != "Home") {
    //   final results = await fetchVideosBycategories(
    //     type: type == "Movies" ? "movie" : "tv",
    //   );

    //   return results;
    // }

    // final recom = Assets.recommendations;

    // final List<ResponseItem> results = [];

    // for (var i = 0; i < recom.length; i++) {
    //   final data = await fetchCategory(recom[i].url);

    //   results.add(
    //     ResponseItem(
    //       name: recom[i].name,
    //       page: data.page,
    //       results: data.results,
    //       totalPages: data.totalPages,
    //       totalResults: data.totalResults,
    //     ),
    //   );
    // }

    // return results;
  }
}
