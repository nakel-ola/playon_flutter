import 'package:flutter/material.dart';

import 'models/models.dart';

class Assets {
  static const String apiKey = "57186edf75b1e0e4312c8aa3ad4c6271";
  static const String baseUrlCategory = "https://api.themoviedb.org/";
  static const String baseUrl = "${baseUrlCategory}3/";
  static const String imageBaseUrl = "https://image.tmdb.org/t/p/original/";
  static const String videoBaseUrl = "https://www.youtube.com/watch";

  static const List<Genre> genres = [
    Genre(id: 28, name: "Action"),
    Genre(id: 12, name: "Adventure"),
    Genre(id: 16, name: "Animation"),
    Genre(id: 35, name: "Comedy"),
    Genre(id: 80, name: "Crime"),
    Genre(id: 99, name: "Documentary"),
    Genre(id: 18, name: "Drama"),
    // Genre(id: 10751, name: "Family"),
    // Genre(id: 14, name: "Fantasy"),
    // Genre(id: 36, name: "History"),
    // Genre(id: 27, name: "Horror"),
    // Genre(id: 10402, name: "Music"),
    // Genre(id: 9648, name: "Mystery"),
    // Genre(id: 666, name: "Now Playing Movies"),
    // Genre(id: 10749, name: "Romance"),
    // Genre(id: 878, name: "Science Fiction"),
    // Genre(id: 333, name: "Trending"),
    // Genre(id: 10770, name: "TV Movie"),
    // Genre(id: 999, name: "Top Rated Movie"),
    // Genre(id: 53, name: "Thriller"),
    // Genre(id: 10752, name: "War"),
    // Genre(id: 37, name: "Western"),
  ];

  static const seriesGenres = [
    Genre(id: 10759, name: "Action & Adventure"),
    Genre(id: 16, name: "Animation"),
    Genre(id: 35, name: "Comedy"),
    Genre(id: 80, name: "Crime"),
    Genre(id: 99, name: "Documentary"),
    Genre(id: 18, name: "Drama"),
    Genre(id: 10751, name: "Family"),
    Genre(id: 10762, name: "Kids"),
    Genre(id: 9648, name: "Mystery"),
    Genre(id: 10763, name: "News"),
    Genre(id: 10764, name: "Reality"),
    Genre(id: 10765, name: "Sci-Fi & Fantasy"),
    Genre(id: 10766, name: "Soap"),
    Genre(id: 10767, name: "Talk"),
    Genre(id: 10768, name: "War & Politics"),
    Genre(id: 37, name: "Western")
  ];

  static final List<Recommendation> movies = genres
      .map(
        (e) => Recommendation(
          name: e.name,
          url:
              "${baseUrl}discover/movie?api_key=$apiKey&with_genres=${e.id}&page=1",
        ),
      )
      .toList();

  static final List<Recommendation> series = seriesGenres
      .map(
        (e) => Recommendation(
          name: e.name,
          url:
              "${baseUrl}discover/tv?api_key=$apiKey&with_genres=${e.id}&page=1",
        ),
      )
      .toList();

  static final List<Color> colors = [
    Colors.red.shade600,
    Colors.pink.shade600,
    Colors.indigo.shade600,
    Colors.purple.shade600,
    Colors.blue.shade600,
    Colors.teal.shade600,
    Colors.green.shade600,
    Colors.yellow.shade600,
    Colors.cyan.shade600,
    Colors.orange.shade600,
    Colors.amber.shade600,
    Colors.grey.shade600,
  ];

  static final List<Recommendation> recommendations = [
    Recommendation(
      name: "Popular",
      url: "${baseUrl}movie/popular?api_key=$apiKey&language=en-US",
    ),
    Recommendation(
      name: "Trending",
      url: "${baseUrl}trending/all/day?api_key=$apiKey",
    ),
    Recommendation(
      name: "Now Playing Movies",
      url: "${baseUrl}movie/now_playing?api_key=$apiKey&language=en-US&page=1",
    ),
    Recommendation(
      name: "Series on Air",
      url: "${baseUrl}tv/on_the_air?api_key=$apiKey&language=en-US&page=1",
    ),
    Recommendation(
      name: "Top Rated Movie",
      url: "${baseUrl}movie/top_rated?api_key=$apiKey&language=en-US&page=1",
    ),
    Recommendation(
      name: "Top Rated Series",
      url: "${baseUrl}tv/top_rated?api_key=$apiKey&language=en-US&page=1",
    )
  ];
}
