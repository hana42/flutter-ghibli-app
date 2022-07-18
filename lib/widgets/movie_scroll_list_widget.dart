import 'package:flutter/material.dart';
import 'package:ghibli/models/movie_model.dart';
import 'package:ghibli/pages/movie_details_page.dart';
import 'package:ghibli/utils/urls.dart';

class MovieCustom extends StatelessWidget {
  final List<Movie> movies;
  final String title;
  final double imageHeight;
  final double imageWidth;

  const MovieCustom({
    Key? key,
    required this.movies,
    required this.title,
    required this.imageHeight,
    required this.imageWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title.toUpperCase(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: imageHeight,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MovieDetailsPage(movies: movies[index]),
                      ),
                    );
                  },
                  child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 20.0,
                      ),
                      padding: EdgeInsets.all(20),
                      width: imageWidth,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              NetworkImage(Urls.imageUrl(movies[index].posterPath!)),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
