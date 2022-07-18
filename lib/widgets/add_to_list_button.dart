import 'package:flutter/material.dart';
import 'package:ghibli/models/movie_model.dart';
import 'package:ghibli/widgets/vertical_icon_button.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddToListButton extends StatefulWidget {
  final Movie movie;
  final String? title;
  final ButtonStyle? style;
  final bool hasTitle;
  const AddToListButton({Key? key, required this.movie, this.title, this.style, required this.hasTitle})
      : super(key: key);

  @override
  State<AddToListButton> createState() => _AddToListButtonState();
}

class _AddToListButtonState extends State<AddToListButton> {
  late final Box box;
  late bool _inList;
  late Movie movie;
  

  @override
  void initState() {
    movie = widget.movie;
    init();
    Hive.boxExists('userMovies');
    _inList = Hive.box('userMovies').values.contains(movie.id);
    super.initState();
  }

  init() async {
    await Hive.openBox('userMovies');
    box = Hive.box('userMovies');
  }

  addMovie(int id) async {
    box.values.contains(id) ? null : box.add(id);
  }

  removeMovie(int id) {
    var boxMap = box.toMap();
    dynamic idKey;
    boxMap.forEach((key, value) {
      if (value == id) idKey = key;
    });
    box.delete(idKey);
  }

  @override
  Widget build(BuildContext context) {
    return VerticalIconButton(
      icon: _inList ? Icons.favorite : Icons.favorite_outline,
      color: Colors.red,
      title: widget.hasTitle == true ? 'List' : null ,
      onTap: () {
        setState(() {
          _inList
              ? removeMovie(movie.id!.toInt())
              : addMovie(movie.id!.toInt()); // addMovie(movie.id!.toInt())
          _inList = !_inList;
        });
      },
    );
  }
}
