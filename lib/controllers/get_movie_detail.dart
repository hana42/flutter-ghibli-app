import 'package:flutter/material.dart';
import 'package:ghibli/models/movie_detail.dart';
import 'package:ghibli/repositories/movies_repository.dart';

class GetMovieDetail {
  final MoviesRepository repository;
  GetMovieDetail(this.repository);

  ValueNotifier<MovieDetail?> movieDetail = ValueNotifier<MovieDetail?>(null);

  get(int id) async {
    movieDetail.value = await repository.getMovieDetail(id);
  }
}
