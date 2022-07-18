import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ghibli/models/movie_detail.dart';
import 'package:ghibli/models/movie_model.dart';
import 'package:ghibli/repositories/movies_remote_data_source.dart';
import 'package:ghibli/repositories/movies_local_data_source.dart';
import 'package:ghibli/repositories/movies_repository_impl.dart';
import 'package:ghibli/controllers/get_movie_detail.dart';
import 'package:ghibli/services/hive_service_impl.dart';
import 'package:ghibli/services/http_service_impl.dart';
import 'package:ghibli/utils/urls.dart';
import 'package:ghibli/widgets/add_to_list_button.dart';
import 'package:ghibli/widgets/youtube_player_widget.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movies;
  const MovieDetailsPage({Key? key, required this.movies}) : super(key: key);

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  final GetMovieDetail getMovieDetail = GetMovieDetail(MoviesRepositoryImpl(
    MoviesRemoteDataSourceImpl(
      httpService: HttpServiceImpl(),
    ),
    MoviesLocalDataSourceImpl(
      hiveService: HiveServiceImpl(),
    ),
  ));

  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    getMovieDetail.get(widget.movies.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.cast),
            onPressed: () {},
          ),
          AddToListButton(
            movie: widget.movies,
            hasTitle: false,
          ),
        ],
      ),
      body: ValueListenableBuilder<MovieDetail?>(
          valueListenable: getMovieDetail.movieDetail,
          builder: (__, movie, _) {
            return movie != null
                ? ListView(
                    children: [
                      Visibility(
                        visible: isVisible,
                        replacement: YoutubePlayerWidget(id: movie.trailerId!),
                        child: Stack(
                          children: [
                            ShaderMask(
                              shaderCallback: (rect) {
                                return LinearGradient(
                                  begin: Alignment.center,
                                  end: Alignment.bottomCenter,
                                  colors: const [
                                    Colors.black,
                                    Colors.transparent
                                  ],
                                ).createShader(Rect.fromLTRB(
                                    0, 0, rect.width, rect.height));
                              },
                              blendMode: BlendMode.dstIn,
                              child: Image.asset(
                                'assets/posterimg/${movie.title.toLowerCase().trim().replaceAll('ä', 'a').replaceAll('\'', '').replaceAll(' ', '')}.jpg',
                                height: 300.0,
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.center,
                                fit: BoxFit.cover,
                                color: Color.fromARGB(255, 177, 0, 0)
                                    .withOpacity(0.45),
                                colorBlendMode: BlendMode.overlay,
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              left: 220,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: TextButton.icon(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color.fromARGB(255, 175, 43, 43)
                                                .withOpacity(0.9)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          bottomLeft: Radius.circular(30)),
                                    )),
                                    fixedSize: MaterialStateProperty.all<Size>(
                                        Size(180, 50)),
                                  ),
                                  label: Text(
                                    'Watch Trailer',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.play_circle_fill,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isVisible = false;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        child: SizedBox(
                          height: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                movie.title.toString(),
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Divider(
                                height: 0,
                                thickness: 0.75,
                                indent: 20,
                                endIndent: 20,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Release'.toUpperCase(),
                                        style: TextStyle(),
                                      ),
                                      Text(
                                        widget.movies.releaseDate!.year
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.yellow[800],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Run time'.toUpperCase(),
                                        style: TextStyle(),
                                      ),
                                      Text(
                                        '${movie.runtime} min',
                                        style: TextStyle(
                                          color: Colors.yellow[800],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Rank'.toUpperCase(),
                                        style: TextStyle(),
                                      ),
                                      Text(
                                        movie.voteAverage.toString(),
                                        style: TextStyle(
                                          color: Colors.yellow[800],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                movie.overview.toString(),
                                maxLines: 5,
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.justify,
                              ),
                              Text('Genres: ${_showGenres(movie.genres)}'),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Voice Actors'.toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                                height: 100,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: movie.credits!.cast.length,
                                  itemBuilder: (context, index) {
                                    var casts = movie.credits!.cast;
                                    return casts[index].profilePath != null
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(80),
                                                child: CachedNetworkImage(
                                                  imageUrl: Urls.imageUrl(
                                                      casts[index]
                                                          .profilePath
                                                          .toString()),
                                                  width: 60,
                                                  height: 60,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      SizedBox(
                                                    width: 60,
                                                    height: 60,
                                                    child: Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    casts[index]
                                                        .name!
                                                        .toUpperCase(),
                                                    textAlign: TextAlign.center,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    'AS ${casts[index].character!.toUpperCase().split(' ')[0]}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 20,
                                              )
                                            ],
                                          )
                                        : SizedBox();
                                  },
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Crew'.toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'muli',
                              ),
                            ),
                            SizedBox(
                                height: 300,
                                child: ListView.builder(
                                  itemCount: movie.credits!.crew
                                      .where((e) => e.profilePath != null)
                                      .map((e) => e.name!)
                                      .toSet()
                                      .toList()
                                      .length,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    var crew = movie.credits!.crew;

                                    var img = crew
                                        .where((e) => e.profilePath != null)
                                        .map((e) => e.profilePath!)
                                        .toSet()
                                        .toList();

                                    var name = crew
                                        .where((e) => e.profilePath != null)
                                        .map((e) => e.name!)
                                        .toSet()
                                        .toList();

                                    var job = crew
                                        .where((e) =>
                                            e.name!.contains(name[index]))
                                        .map((e) => e.job)
                                        .toString()
                                        .replaceAll('(', '')
                                        .replaceAll(')', '');

                                    return Column(
                                      children: [
                                        Container(
                                          height: 200,
                                          width: 160,
                                          padding: EdgeInsets.all(8),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: CachedNetworkImage(
                                                imageUrl:
                                                    Urls.imageUrl(img[index]),
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    SizedBox(
                                                      height: 200,
                                                      width: 160,
                                                      child: Center(
                                                          child:
                                                              CircularProgressIndicator()),
                                                    ),
                                                errorWidget:
                                                    (context, error, dynamic) {
                                                  return Text('error');
                                                }),
                                          ),
                                        ),
                                        Text(
                                          name[index],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          job,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                )),
                          ],
                        ),
                      ),
                    ],
                  )
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}

String _showGenres(List<Genre> genres) {
  String result = '';
  for (var genre in genres) {
    result += '${genre.name}, ';
  }

  if (result.isEmpty) {
    return result;
  }

  return result.substring(0, result.length - 2);
}
