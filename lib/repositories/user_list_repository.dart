import 'package:ghibli/models/movie_model.dart';
import 'package:ghibli/services/hive_service.dart';

abstract class UserListRepository {
  Future<void> addMovie(Movie movies);
  Future<List<Movie>?> getMovies();
  Future<void> deleteMovie(Movie movie);
  Future<void> deleteAll();
}

class UserListRepositoryImpl implements UserListRepository {
  final HiveService hiveService;
  UserListRepositoryImpl({required this.hiveService});

  final String moviesBox = 'userMovieList';
  
  @override
  Future<void> addMovie(Movie movie) async {
    await hiveService.addItems(moviesBox, [movie]);
  }
  
  @override
  Future<void> deleteAll() async {
    await hiveService.deleteAll(moviesBox);
  }
  
  @override
  Future<void> deleteMovie(Movie movie) async {
    await hiveService.deleteItem(moviesBox, movie);
  }
  
  @override
  Future<List<Movie>?> getMovies() async {
    return await hiveService.getItems(moviesBox);
  }

 
}
