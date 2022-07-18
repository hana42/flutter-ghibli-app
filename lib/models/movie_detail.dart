// To parse this JSON data, do
//
//     final movieDetail = movieDetailFromJson(jsonString);

import 'dart:convert';

import 'package:ghibli/models/credits_model.dart';

MovieDetail movieDetailFromJson(String str) =>
    MovieDetail.fromJson(json.decode(str));

String movieDetailToJson(MovieDetail data) => json.encode(data.toJson());

class MovieDetail {
  MovieDetail({
    required this.adult,
    required this.backdropPath,
    required this.budget,
    required this.genres,
    required this.id,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.tagline,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String backdropPath;
  final int budget;
  final List<Genre> genres;
  final int id;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<ProductionCompany> productionCompanies;
  final DateTime releaseDate;
  final int revenue;
  final int runtime;
  final String tagline;
  final String title;
  final double voteAverage;
  final int voteCount;

  Credits? credits;
  String? trailerId;

  factory MovieDetail.fromJson(Map<String, dynamic> json) => MovieDetail(
        adult: json['adult'],
        backdropPath: json['backdrop_path'],
        budget: json['budget'],
        genres: List<Genre>.from(json['genres'].map((x) => Genre.fromJson(x))),
        id: json['id'],
        overview: json['overview'],
        popularity: json['popularity'].toDouble(),
        posterPath: json['poster_path'],
        productionCompanies: List<ProductionCompany>.from(
            json['production_companies']
                .map((x) => ProductionCompany.fromJson(x))),
        releaseDate: DateTime.parse(json['release_date']),
        revenue: json['revenue'],
        runtime: json['runtime'],
        tagline: json['tagline'],
        title: json['title'],
        voteAverage: json['vote_average'].toDouble(),
        voteCount: json['vote_count'],
      );

  Map<String, dynamic> toJson() => {
        'adult': adult,
        'backdrop_path': backdropPath,
        'budget': budget,
        'genres': List<dynamic>.from(genres.map((x) => x.toJson())),
        'id': id,
        'overview': overview,
        'popularity': popularity,
        'poster_path': posterPath,
        'production_companies':
            List<dynamic>.from(productionCompanies.map((x) => x.toJson())),
        'release_date':
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        'revenue': revenue,
        'runtime': runtime,
        'tagline': tagline,
        'title': title,
        'vote_average': voteAverage,
        'vote_count': voteCount,
      };
}

class Genre {
  Genre({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  Genre copyWith({
    required int id,
    required String name,
  }) =>
      Genre(
        id: this.id,
        name: this.name,
      );

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

class ProductionCompany {
  ProductionCompany({
    required this.id,
    required this.name,
    required this.originCountry,
  });

  final int id;
  final String name;
  final String originCountry;

  ProductionCompany copyWith({
    required int id,
    required String? logoPath,
    required String name,
    required String originCountry,
  }) =>
      ProductionCompany(
        id: this.id,
        name: this.name,
        originCountry: this.originCountry,
      );

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      ProductionCompany(
        id: json['id'],
        name: json['name'],
        originCountry: json['origin_country'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'origin_country': originCountry,
      };
}
