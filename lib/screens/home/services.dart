import '../../assets.dart';
import '../../models/models.dart';
import '../../services/videos_service.dart';

class Services {
  VideosService videosService = VideosService();

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

    final String newType = type == "Home"
        ? "movie"
        : type == "Movies"
            ? "movie"
            : "tv";

    final List<ResponseItem> results = [];

    for (var i = 0; i < items.length; i++) {
      final data = await videosService.fetchByCategory(items[i].url, newType);

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
  }
}
