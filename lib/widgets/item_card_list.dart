import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ghibli/models/movie_model.dart';
import 'package:ghibli/pages/movie_details_page.dart';
import 'package:ghibli/utils/urls.dart';

class ItemCard extends StatelessWidget {
  final Movie movie;

  const ItemCard({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MovieDetailsPage(movies: movie)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.only(bottom: 12),
        height: 200,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 36, 36, 36),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CachedNetworkImage(
                  imageUrl: Urls.imageUrl(
                    movie.posterPath!,
                  ),
                  fit: BoxFit.fill,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title ?? '-',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style:
                          TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(movie.releaseDate!.year.toString()),
                        ),
                        const SizedBox(width: 16),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          (movie.voteAverage!).toString(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      movie.overview ?? '',
                      overflow: TextOverflow.fade,
                      maxLines: 7,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
