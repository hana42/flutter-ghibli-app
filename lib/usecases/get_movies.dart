// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:ghibli/models/movie_model.dart';
import 'package:ghibli/repositories/movies_repository.dart';
import 'package:ghibli/services/hive_service_impl.dart';

class GetMovies {
  final MoviesRepository repository;
  GetMovies(this.repository) {
    get();
  }

  ValueNotifier<List<Movie>?> movies = ValueNotifier<List<Movie>?>(null);

  get() async {
    bool exists = await HiveServiceImpl().boxExists('movies');

    if (exists) {
      print('getting cache');
      movies.value = await repository.getCache();
    } else {
      print('getting api');
      movies.value = await repository.getMovies();
      print('saving cache');
      await repository.saveCache(movies.value!);
    }
  }
}
