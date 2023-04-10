import '../assets.dart';
import '../models/recommendation.dart';

final List<Recommendation> recommendations = [
  Recommendation(
    name: "Trending",
    url:
        "https://api.themoviedb.org/3/trending/all/day?api_key=${Assets.apiKey}",
  ),
  Recommendation(
    name: "Now Playing Movies",
    url:
        "https://api.themoviedb.org/3/movie/now_playing?api_key=${Assets.apiKey}&language=en-US&page=1",
  ),
  Recommendation(
    name: "Series on Air",
    url:
        "https://api.themoviedb.org/3/tv/on_the_air?api_key=${Assets.apiKey}&language=en-US&page=1",
  ),
  Recommendation(
    name: "Top Rated Movie",
    url:
        "https://api.themoviedb.org/3/movie/top_rated?api_key=${Assets.apiKey}&language=en-US&page=1",
  ),
  Recommendation(
    name: "Top Rated Series",
    url:
        "https://api.themoviedb.org/3/tv/top_rated?api_key=${Assets.apiKey}&language=en-US&page=1",
  )
];
