class Urls {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = 'api_key=a3305d60fd805e09d58bc42f503f3432';

  /// Movies
  static String movies = '$baseUrl/list/4309?$apiKey';
  static String movieDetail(int id) => '$baseUrl/movie/$id?$apiKey';
  static String movieRecommendations(int id) =>
      '$baseUrl/movie/$id/recommendations?$apiKey';
  static String movieTrailer(int id) => '$baseUrl/movie/$id/videos?$apiKey';
  static String movieCredits(int id) => '$baseUrl/movie/$id/credits?$apiKey';

  /// Image
  static const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';
  static String imageUrl(String path) => '$baseImageUrl$path';
  static String movieImages(int id) =>
      '$baseUrl/movie/$id/images?$apiKey&language=en-US&include_image_language=en,null';
}
