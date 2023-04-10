import 'video.dart';

class ApiResponse {
  final int page;
  final List<Video> results;
  final int totalPages;
  final int totalResults;

  ApiResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });
}

class ResponseItem extends ApiResponse {
  final String name;
  ResponseItem({
    required this.name,
    required super.page,
    required super.results,
    required super.totalPages,
    required super.totalResults,
  });
}
