import 'package:ghibli/models/movie_detail.dart';
import 'package:ghibli/models/movie_model.dart';
import 'package:ghibli/repositories/movies_remote_data_source.dart';
import 'package:ghibli/repositories/movies_local_data_source.dart';
import 'package:ghibli/repositories/movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesRemoteDataSource remoteDataSource;
  final MoviesLocalDataSource localDataSource;
  MoviesRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<List<Movie>> getMovies() async {
    final result = await remoteDataSource.getMovies();
    return result;
  }

  @override
  Future<MovieDetail> getMovieDetail(int id) async {
    final result = await remoteDataSource.getMovieDetail(id);
    return result;
  }

  @override
  Future<void> saveCache(List<Movie> movies) async {
    await localDataSource.saveCache(movies);
  }

  @override
  Future<List<Movie>?> getCache() async {
    final result = await localDataSource.getCache();
    return result;
  }
}
