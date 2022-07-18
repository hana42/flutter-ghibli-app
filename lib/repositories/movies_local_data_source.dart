import 'package:ghibli/models/movie_model.dart';
import 'package:ghibli/services/hive_service.dart';

abstract class MoviesLocalDataSource {
  Future<void> saveCache(List<Movie> movies);
  Future<List<Movie>?> getCache();
}

class MoviesLocalDataSourceImpl implements MoviesLocalDataSource {
  final HiveService hiveService;
  MoviesLocalDataSourceImpl({required this.hiveService});

  final String moviesBox = 'movies';

  @override
  Future<List<Movie>?> getCache() async {
    return await hiveService.getItems(moviesBox);
  }

  @override
  Future<void> saveCache(List<Movie> movies) async {
    await hiveService.addItems(moviesBox, movies);
  }
}
