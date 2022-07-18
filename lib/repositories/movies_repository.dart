import 'package:ghibli/models/movie_detail.dart';
import 'package:ghibli/models/movie_model.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getMovies();
  Future<MovieDetail> getMovieDetail(int id);

  Future<void> saveCache(List<Movie> movies);
  Future<List<Movie>?> getCache();
}