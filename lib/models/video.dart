class Video {
  final bool? adult;
  final String? backdropPath;
  final List<dynamic>? genreIds;
  final int? id;
  final String? name;
  final String? description;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final dynamic popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final dynamic voteAverage;
  final dynamic voteCount;
  final bool? video;
  final String? type;

  const Video({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.name,
    this.description,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.voteAverage,
    this.voteCount,
    this.video,
    this.type,
  });

  Video copyWith({
    bool? adult,
    String? backdropPath,
    List<dynamic>? genreIds,
    dynamic id,
    String? name,
    String? description,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    dynamic popularity,
    String? posterPath,
    String? releaseDate,
    String? title,
    dynamic voteAverage,
    dynamic voteCount,
    bool? video,
    String? type,
  }) {
    return Video(
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      genreIds: genreIds ?? this.genreIds,
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalTitle: originalTitle ?? this.originalTitle,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      posterPath: posterPath ?? this.posterPath,
      releaseDate: releaseDate ?? this.releaseDate,
      title: title ?? this.title,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      video: video ?? this.video,
      type: type ?? this.type,
    );
  }

  Map toJson() => {
        'adult': adult,
        'backdrop_path': backdropPath,
        'genre_ids': genreIds,
        'id': id,
        'name': name,
        'description': description,
        'original_language': originalLanguage,
        'original_title': originalTitle,
        'overview': overview,
        'popularity': popularity,
        'poster_path': posterPath,
        'release_date': releaseDate,
        'title': title,
        'vote_average': voteAverage,
        'vote_count': voteCount,
        'video': video,
        'type': type,
      };
}
