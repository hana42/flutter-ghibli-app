import 'package:flutter/material.dart';
import 'package:ghibli/models/genre_model.dart';
import 'package:ghibli/models/movie_model.dart';
import 'package:ghibli/pages/movie_details_page.dart';
import 'package:ghibli/utils/urls.dart';

class CategoryWidget extends StatelessWidget {
  final String selectedGenre;
  final List<Movie> movie;

  final List genres = [
    Genres(id: 28, name: 'Action'),
    Genres(id: 12, name: 'Adventure'),
    Genres(id: 16, name: 'Animation'),
    Genres(id: 35, name: 'Comedy'),
    Genres(id: 80, name: 'Crime'),
    Genres(id: 99, name: 'Documentary'),
    Genres(id: 18, name: 'Drama'),
    Genres(id: 10751, name: 'Family'),
    Genres(id: 14, name: 'Fantasy'),
    Genres(id: 36, name: 'History'),
    Genres(id: 27, name: 'Horror'),
    Genres(id: 10402, name: 'Music'),
    Genres(id: 9648, name: 'Mystery'),
    Genres(id: 10749, name: 'Romance'),
    Genres(id: 878, name: 'Science Fiction'),
    Genres(id: 10770, name: 'TV Movie'),
    Genres(id: 53, name: 'Thriller'),
    Genres(id: 10752, name: 'War'),
    Genres(id: 37, name: 'Western')
  ];

  CategoryWidget({
    Key? key,
    required this.selectedGenre,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(12, 40, 8, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  genres
                      .firstWhere(
                          (element) => element.id.toString() == selectedGenre)
                      .name!.toString().toUpperCase(),
                  style: TextStyle(
                    letterSpacing: 1.8,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  // ignore: avoid_print
                  onTap: () => print('Categories $selectedGenre'),
                  child: Icon(
                    Icons.arrow_forward,
                    size: 20.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 230,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movie.length,
              itemBuilder: (BuildContext context, int index) {
                if (movie[index]
                    .genreIds!
                    .any((e) => e.toString() == selectedGenre)) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MovieDetailsPage(movies: movie[index]),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 580,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: SizedBox(
                          width: 160,
                          height: 580,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: SizedBox(
                              width: 200,
                              height: 580,
                              child: Image.network(
                                Urls.imageUrl(
                                    movie[index].posterPath.toString()),
                                width: 20,
                                height: 500,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
