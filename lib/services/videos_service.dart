import 'package:dio/dio.dart';

import '../assets.dart';
import '../models/models.dart';

class VideosService {
  Future<T> fetchData<T>(String url) async {
    try {
      final res = await Dio().get(url);

      return res.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse> fetchByCategory(String url, String? type) async {
    final data = await fetchData(url);

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
            releaseDate: e["release_date"] ?? e["first_air_date"],
            title: e["title"],
            type: type ?? e["media_type"],
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

  Future<List<Trailer>> getTrailers(String type, int id) async {
    String url = "${Assets.baseUrl}$type/$id/videos?api_key=${Assets.apiKey}";

    final data = await fetchData(url);

    final List<Trailer> items = (data["results"] as List)
        .map(
          (e) => Trailer(
            id: e["id"],
            iso_3166_1: e["iso_3166_1"],
            iso_639_1: e["iso_639_1"],
            key: e["key"],
            name: e["name"],
            official: e["official"],
            publishedAt: e["published_at"],
            site: e["site"],
            size: e["size"],
            type: e["type"],
          ),
        )
        .toList();

    return items;
  }

  Future<List<Cast>> getCast(dynamic id) async {
    try {
      final url = "${Assets.baseUrl}movie/$id/credits?api_key=${Assets.apiKey}";

      final data = await fetchData(url);

      List<Cast> items = (data["cast"] as List)
          .map(
            (e) => Cast(
              adult: e["adult"],
              castId: e["cast_id"],
              ceditId: e["cedit_id"],
              character: e["character"],
              gender: e["gender"],
              id: e["id"],
              knownForDepartment: e["known_for_department"],
              name: e["name"],
              orignalName: e["orignal_name"],
              popularity: e["popularity"],
              profilePath: e["profile_path"],
            ),
          )
          .toList();
      return items;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<Review>> getReviews(
      {required dynamic id, required String type}) async {
    try {
      final url =
          "${Assets.baseUrl}$type/$id/reviews?api_key=${Assets.apiKey}&language=en-US&page=1";

      final response = await fetchData(url);

      final List<Review> data = (response["results"] as List)
          .map(
            (e) => Review(
              author: e["author"],
              authorDetails: AuthorDetails(
                name: e["author_details"]["name"],
                rating: e["author_details"]["rating"],
                username: e["author_details"]["username"],
                avatarPath: e["author_details"]["avatar_path"],
              ),
              content: e["content"],
              createdAt: e["created_at"],
              id: e["id"],
              updatedAt: e["updated_at"],
              url: e["url"],
            ),
          )
          .toList();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse> getSimilarVideos(dynamic id, String type) async {
    try {
      final url =
          "${Assets.baseUrl}/$type/$id/similar?api_key=${Assets.apiKey}";

      final data = await fetchData(url);

      final List<Video> results = (data["results"] as List)
          .map((e) => Video(
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
                releaseDate: e["release_date"] ?? e["first_air_date"],
                title: e["title"],
                type: type,
                video: e["video"],
                voteAverage: e["vote_average"],
                voteCount: e["vote_count"],
              ))
          .toList();

      return ApiResponse(
        page: data["page"],
        results: results,
        totalPages: data["total_pages"],
        totalResults: data["total_results"],
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse> getRecommendedVideos(dynamic id, String type) async {
    try {
      final url =
          "${Assets.baseUrl}/$type/$id/recommendations?api_key=${Assets.apiKey}&language=en-US&page=1";

      final data = await fetchData(url);

      final List<Video> results = (data["results"] as List)
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
              releaseDate: e["release_date"] ?? e["first_air_date"],
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
    } catch (e) {
      rethrow;
    }
  }
}
