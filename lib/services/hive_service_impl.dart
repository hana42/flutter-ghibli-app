import 'package:ghibli/models/movie_model.dart';
import 'package:ghibli/services/hive_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveServiceImpl implements HiveService {
  @override
  Future<bool> boxExists(String boxName) async {
    final openBox = await Hive.openBox<Movie>(boxName);
    int length = openBox.length;
    return length > 1;
  }

  @override
  Future<void> addItems(String boxName, List<Movie> movies) async {
    Box<Movie> box = await Hive.openBox(boxName);
    await box.addAll(movies);
  }

  @override
  Future<List<Movie>?> getItems(String boxName) async {
    Box<Movie> box = await Hive.openBox(boxName);
    return box.values.toList();
  }

  @override
  Future<void> deleteItem(String boxName, var item) async {
    bool exists = await boxExists(boxName);
    if (exists) {
      Box box = Hive.box(boxName);
      await box.delete(item.key);
    }
  }

  @override
  Future<void> deleteAll(String boxName) async {
    bool exists = await boxExists(boxName);
    if (exists) {
      Box box = await Hive.openBox(boxName);
      await box.clear();
    }
  }
}
