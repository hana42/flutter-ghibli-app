import 'package:ghibli/models/movie_model.dart';

abstract class HiveService {
  Future<bool> boxExists(String boxName);
  Future<void> addItems(String boxName, List<Movie> movies);
  Future<List<Movie>?> getItems(String boxName);
  Future<void> deleteItem(String boxName, Movie movie);
  Future<void> deleteAll(String boxName);
}
