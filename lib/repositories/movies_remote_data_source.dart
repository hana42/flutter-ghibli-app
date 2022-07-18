import 'package:ghibli/models/credits_model.dart';
import 'package:ghibli/models/movie_detail.dart';
import 'package:ghibli/models/movie_model.dart';
import 'package:ghibli/services/http_service.dart';
import 'package:ghibli/utils/urls.dart';

abstract class MoviesRemoteDataSource {
  Future<List<Movie>> getMovies();
  Future<MovieDetail> getMovieDetail(int id);
}

class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  final HttpService httpService;
  MoviesRemoteDataSourceImpl({required this.httpService});

  @override
  Future<List<Movie>> getMovies() async {
    var response = await httpService.get(Urls.movies);
    var movies = response['items'] as List;
    List<Movie> movie = [for (final item in movies) Movie.fromJson(item)];

    return movie;
  }

  @override
  Future<MovieDetail> getMovieDetail(int id) async {
    final response = await httpService.get(Urls.movieDetail(id));
    MovieDetail movieDetail = MovieDetail.fromJson(response);
    
    movieDetail.trailerId = await getYoutubeId(id);
    movieDetail.credits = await getCredits(id);

    return movieDetail;
  }

  Future<String> getYoutubeId(int id) async {
    final response = await httpService.get(Urls.movieTrailer(id));
    var youtubeId = response['results'][0]['key'];

    return youtubeId;
  }

  Future<Credits?> getCredits(int id) async {
    final response = await httpService.get(Urls.movieCredits(id));
    var list = response;
    Credits credits = Credits.fromJson(list);

    return credits;
  }
}
