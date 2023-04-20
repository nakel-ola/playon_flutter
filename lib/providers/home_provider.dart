import 'package:flutter/material.dart';

import '../assets.dart';
import '../models/models.dart';
import '../services/videos_service.dart';

class HomeProvider extends ChangeNotifier {
  VideosService videosService = VideosService();
  double _scrollOffset = 0.0;
  String _active = "Home";
  int _currentPageIndex = 0;
  dynamic _pageArgs;

  final List<ResponseItem> _randomItems = [], _movies = [], _series = [];

  double get scrollOffset => _scrollOffset;
  String get activeMenu => _active;
  int get currentPageIndex => _currentPageIndex;
  dynamic get pageArgs => _pageArgs;

  List<ResponseItem> get videos => _active == "Home"
      ? _randomItems
      : _active == "Movies"
          ? _movies
          : _series;

  void updateCurrentPage({required int index, dynamic args}) {
    _currentPageIndex = index;
    _pageArgs = args;
    notifyListeners();
  }

  void updateOffset(double value) {
    _scrollOffset = value;
    notifyListeners();
  }

  updateActive(String value) async {
    _active = value;
    notifyListeners();
    await getData(type: value);
  }

  getVideos(List<Recommendation> items, String type) async {
    final String newType = type == "Home"
        ? "movie"
        : type == "Movies"
            ? "movie"
            : "tv";

    for (var i = 0; i < items.length; i++) {
      final item = await videosService.fetchByCategory(items[i].url, newType);

      final data = ResponseItem(
        name: items[i].name,
        page: item.page,
        results: item.results,
        totalPages: item.totalPages,
        totalResults: item.totalResults,
      );

      if (type == "Home") _randomItems.add(data);
      if (type == "Movies") _movies.add(data);
      if (type == "Series") _series.add(data);

      notifyListeners();
    }
  }

  Future<void> getData({
    required String type,
  }) async {
    if (type == "Home" &&
        _randomItems.isNotEmpty &&
        _randomItems.length == Assets.recommendations.length) return;
    if (type == "Movies" &&
        _movies.isNotEmpty &&
        _movies.length == Assets.movies.length) return;
    if (type == "Series" &&
        _series.isNotEmpty &&
        _series.length == Assets.series.length) return;

    final List<Recommendation> data = type == "Home"
        ? Assets.recommendations
        : type == "Movies"
            ? Assets.movies
            : Assets.series;

    final items = data.skip(videos.length).take(2).toList();

    getVideos(items, type);
  }

  void initailize() async {
    await getData(type: _active);
  }
}
