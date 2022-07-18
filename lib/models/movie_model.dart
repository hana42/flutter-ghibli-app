import 'package:hive_flutter/hive_flutter.dart';

part 'movie_model.g.dart';

@HiveType(typeId: 0)
class Movie extends HiveObject {
  @HiveField(0)
  final String? backdropPath;
  @HiveField(1)
  final List<int>? genreIds;
  @HiveField(2)
  final int? id;
  @HiveField(3)
  final String? overview;
  @HiveField(4)
  final double? popularity;
  @HiveField(5)
  final String? posterPath;
  @HiveField(6)
  final DateTime? releaseDate;
  @HiveField(7)
  final String? title;
  @HiveField(8)
  final double? voteAverage;
  @HiveField(9)
  final int? voteCount;

  Movie({
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        backdropPath: json['backdrop_path'],
        genreIds: List<int>.from(json['genre_ids'].map((x) => x)),
        id: json['id'],
        overview: json['overview'],
        popularity: json['popularity'].toDouble(),
        posterPath: json['poster_path'],
        releaseDate: DateTime.parse(json['release_date']),
        title: json['title'],
        voteAverage: json['vote_average'].toDouble(),
        voteCount: json['vote_count'],
      );

  Map<String, dynamic> toJson() => {
        'backdrop_path': backdropPath,
        'genre_ids': List<dynamic>.from(genreIds!.map((x) => x)),
        'id': id,
        'overview': overview,
        'popularity': popularity,
        'poster_path': posterPath,
        'release_date':
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        'title': title,
        'vote_average': voteAverage,
        'vote_count': voteCount,
      };

  Movie copyWith({
    String? backdropPath,
    List<int>? genreIds,
    int? id,
    String? overview,
    double? popularity,
    String? posterPath,
    String? releaseDate,
    String? title,
    String? voteAverage,
    int? voteCount,
  }) {
    return Movie(
      backdropPath: this.backdropPath,
      genreIds: this.genreIds,
      id: this.id,
      overview: this.overview,
      popularity: this.popularity,
      posterPath: this.posterPath,
      releaseDate: this.releaseDate,
      title: this.title,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
