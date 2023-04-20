import '../assets.dart';
import '../models/models.dart';

List<String> findGenreByIds(List<dynamic> ids) {
  if (ids.isEmpty) return [];

  final List<dynamic> newIds = ids.take(3).toList();

  final List<String> results = [];
  final List<Genre> genres = [...Assets.genres, ...Assets.seriesGenres];

  for (var i = 0; i < newIds.length; i++) {
    final genre = genres.firstWhere((el) => el.id == newIds[i]);
    results.add(genre.name);
  }

  return results;
}
