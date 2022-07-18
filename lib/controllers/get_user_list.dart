// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:ghibli/models/movie_model.dart';
import 'package:ghibli/repositories/user_list_repository.dart';

class GetUserList {
  final UserListRepository repository;
  GetUserList(this.repository) {
    get();
  }

  ValueNotifier<List<Movie>?> movies = ValueNotifier<List<Movie>?>(null);

  get() async {
    print('getting list');
    movies.value = await repository.getMovies();
  }
}
