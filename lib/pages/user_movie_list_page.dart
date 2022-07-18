import 'package:flutter/material.dart';
import 'package:ghibli/models/movie_model.dart';
import 'package:ghibli/widgets/item_card_list.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserList extends StatefulWidget {
  final List<Movie> movies;
  const UserList({Key? key, required this.movies}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  Box box = Hive.box('userMovies');

  @override
  void initState() {
    super.initState();
  }

  _delete(int index) {
    box.deleteAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (BuildContext context, Box box, Widget? child) {
                  if (box.isEmpty) {
                    return Center(child: Text('Empty'));
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: box.values.length,
                              itemBuilder: (BuildContext context, int index) {
                                var list = widget.movies
                                    .where((e) => e.id == box.getAt(index));
                                return SizedBox(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  child: ItemCard(movie: list.first),
                                );
                              }),
                        ),
                      ],
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
