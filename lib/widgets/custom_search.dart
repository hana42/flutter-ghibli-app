import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ghibli/usecases/get_movies.dart';
import 'package:ghibli/models/movie_model.dart';
import 'package:ghibli/repositories/movies_remote_data_source.dart';
import 'package:ghibli/repositories/movies_local_data_source.dart';
import 'package:ghibli/repositories/movies_repository_impl.dart';
import 'package:ghibli/services/hive_service_impl.dart';
import 'package:ghibli/services/http_service_impl.dart';
import 'package:ghibli/utils/urls.dart';

typedef SearchFilter<T> = List Function(T t);
typedef ResultBuilder<T> = Widget Function(T t);

class CustomSearchDelegate<T> extends SearchDelegate<T?> {
  final GetMovies _controller = GetMovies(
    MoviesRepositoryImpl(
      MoviesRemoteDataSourceImpl(
        httpService: HttpServiceImpl(),
      ),
      MoviesLocalDataSourceImpl(
        hiveService: HiveServiceImpl(),
      ),
    ),
  );

  final bool showItemsOnEmpty;
  final Widget suggestion;
  final Widget failure;
  final SearchFilter filter;
  final String? searchLabel;
  final void Function(String)? onQueryUpdate;
  final TextStyle? searchStyle;

  CustomSearchDelegate({
    this.suggestion = const SizedBox(),
    this.failure = const SizedBox(),
    required this.filter,
    this.showItemsOnEmpty = true,
    this.searchLabel,
    this.onQueryUpdate,
    this.searchStyle,
  }) : super(
          searchFieldLabel: searchLabel,
          searchFieldStyle: searchStyle,
        );

  List<String> cards = const [
    'assets/cards/castleinthesky.jpg',
    'assets/cards/fromuponpoppyhill.jpg',
    'assets/cards/graveofthefireflies.jpg',
    'assets/cards/howlsmovingcastle.jpg',
    'assets/cards/kikisdeliveryservice.jpg',
    'assets/cards/myneighborstheyamadas.jpg',
    'assets/cards/myneighbortotoro.jpg',
    'assets/cards/nausicaaofthevalleyofthewind.jpg',
    'assets/cards/oceanwaves.jpg',
    'assets/cards/onlyyesterday.jpg',
    'assets/cards/pompoko.jpg',
    'assets/cards/ponyo.jpg',
    'assets/cards/porcorosso.jpg',
    'assets/cards/princessmononoke.jpg',
    'assets/cards/spiritedaway.jpg',
    'assets/cards/talesfromearthsea.jpg',
    'assets/cards/thecatreturns.jpg',
    'assets/cards/thesecretworldofarrietty.jpg',
    'assets/cards/thetaleoftheprincesskaguya.jpg',
    'assets/cards/thewindrises.jpg',
    'assets/cards/whenmarniewasthere.jpg',
    'assets/cards/whisperoftheheart.jpg'
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.cancel_outlined),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) => buildSuggestions(context);

  @override
  Widget buildSuggestions(BuildContext context) {
    if (onQueryUpdate != null) onQueryUpdate!(query);

    final String cleanQuery = query.toLowerCase().trim();
    return ValueListenableBuilder<List<Movie>?>(
      valueListenable: _controller.movies,
      builder: (_, movies, __) {
        List<Movie> result = movies!
            .where(
              (item) => filter(item)
                  .map((value) => value.toString().toLowerCase().trim())
                  .any((value) {
                return value == cleanQuery ||
                    value.contains(cleanQuery) ||
                    value.startsWith(cleanQuery) ||
                    value.endsWith(cleanQuery);
              }),
            )
            .toList();

        return cleanQuery.isEmpty && !showItemsOnEmpty
            ? suggestion
            : result.isEmpty
                ? failure
                : ListView.builder(
                    itemCount: result.length,
                    itemBuilder: (BuildContext context, int index) {
                      var img = cards
                          .where((e) => e.endsWith(
                              '${result[index].title!.toLowerCase().split(' ').last}.jpg'))
                          .toString()
                          .replaceAll('(', '')
                          .replaceAll(')', '');
                      return img.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 18),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.asset(
                                  img,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                Text(result[index].title!),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 18),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: CachedNetworkImage(
                                      imageUrl: Urls.imageUrl(
                                          result[index].backdropPath!),
                                      fit: BoxFit.contain,
                                      width: 200,
                                      height: 200,
                                    ),
                                  ),
                                ),
                              ],
                            );
                    },
                  );
      },
    );
  }
}
