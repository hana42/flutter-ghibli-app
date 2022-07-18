import 'package:flutter/material.dart';
import 'package:ghibli/models/movie_model.dart';
import 'package:ghibli/widgets/category_widget.dart';
import 'package:ghibli/widgets/movie_highlighted_widget.dart';
import 'package:ghibli/widgets/movie_scroll_list_widget.dart';

class MoviesPage extends StatelessWidget {
  final List<Movie> movies;

  const MoviesPage({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MovieHighlightedWidget(
            movie: movies[12],
            assetImage: 'assets/highlighted/spiritedaway.jpg',
            assetTitle: 'assets/titles/spiritedaway.png'),
        MovieCustom(
            movies: movies.where((e) => e.voteAverage! > 8).toList(),
            title: 'Most Popular',
            imageHeight: 250,
            imageWidth: 150),
        for (var id in [12, 14, 18, 10751, 10752, 10749])
          CategoryWidget(
              selectedGenre: id.toString(),
              movie: movies,
              ),
      ],
    );
  }
}
