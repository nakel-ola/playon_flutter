import '../../assets.dart';
import '../../models/models.dart';
import '../../services/videos_service.dart';

class Services {
  VideosService videosService = VideosService();

  Future<ApiResponse> getData(
      {required String type, required String genre, int page = 1}) {
    String newType = type == "Movies" ? "movie" : "tv";
    if (genre == "Trending") {
      String url =
          "${Assets.baseUrl}trending/all/day?api_key=${Assets.apiKey}&language=en-US";
      return videosService.fetchByCategory(url, newType);
    }

    if (genre == "Now Playing Movies") {
      String url =
          "${Assets.baseUrl}movie/now_playing?api_key=${Assets.apiKey}&language=en-US&page=$page";
      return videosService.fetchByCategory(url, newType);
    }

    if (genre == "Top Rated Movie" || genre == "Top Rated Series") {
      String url =
          "${Assets.baseUrl}$newType/top_rated?api_key=${Assets.apiKey}&language=en-US&page=$page";
      return videosService.fetchByCategory(url, newType);
    }

    if (genre == "Series on Air") {
      String url =
          "${Assets.baseUrl}tv/on_the_air?api_key=${Assets.apiKey}&language=en-US&page=$page";
      return videosService.fetchByCategory(url, newType);
    }

    final items = newType == "movie" ? Assets.genres : Assets.seriesGenres;

    final newGenre = items.firstWhere((el) => el.name == genre);

    String url =
        "${Assets.baseUrl}discover/$newType?api_key=${Assets.apiKey}&with_genres=${newGenre.id}&page=$page";

    return videosService.fetchByCategory(url, newType);
  }
}
