part of '../../../../services/services.dart';

/// movie servces
class MovieServices {
  /// Get Movies From Api
  static Future<List<Movie>> getMovies(int page) async {
    String url =
        "https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey&language=en-US&page=$page";
    var response = await http.get(url);
    if (response.statusCode != 200) {
      return [];
    }
    var data = json.decode(response.body);
    List result = data['results'];
    return result.map((e) => Movie.fromJson(e)).toList();
  }

  /// Get Detail Movie
  static Future<MovieDetail> getDetails(Movie movie,
      {int movieID, http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/movie/${movieID ?? movie.id}?api_key=$apiKey&language=en-US";

    client ??= http.Client();

    var response = await client.get(url);
    var data = json.decode(response.body);

    List genres = (data as Map<String, dynamic>)['genres'];
    String language;

    switch ((data as Map<String, dynamic>)['original_language'].toString()) {
      case 'ja':
        language = "Japanese";
        break;
      case 'id':
        language = "Indonesian";
        break;
      case 'ko':
        language = "Korean";
        break;
      case 'en':
        language = "English";
        break;
    }

    return movieID != null
        ? MovieDetail(Movie.fromJson(data),
            language: language,
            genres: genres
                .map((e) => (e as Map<String, dynamic>)['name'].toString())
                .toList())
        : MovieDetail(movie,
            language: language,
            genres: genres
                .map((e) => (e as Map<String, dynamic>)['name'].toString())
                .toList());
  }

  /// Get Movie coming Soon
  static Future<List<Movie>> getMoviesComingSoon(
    int page,
  ) async {
    String url =
        "https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey&language=en-US&page=$page";

    var response = await http.get(url);
    if (response.statusCode != 200) {
      return [];
    }
    var data = json.decode(response.body);
    List result = data['results'];
    return result.map((e) => Movie.fromJson(e)).toList();
  }

  /// Get Credit Actor
  static Future<List<Credit>> getCredits(
    int movieID,
  ) async {
    String url =
        "https://api.themoviedb.org/3/movie/$movieID/credits?api_key=$apiKey";
    var response = await http.get(url);
    var data = json.decode(response.body);

    return ((data as Map<String, dynamic>)['cast'] as List)
        .map((e) => Credit(
            name: (e as Map<String, dynamic>)['name'],
            profilePath: (e as Map<String, dynamic>)['profile_path']))
        .toList();
  }

  ///Get Videos Trailer Movie
  static Future<List<VideosModel>> getVideos(
    int movieID,
  ) async {
    String url =
        "https://api.themoviedb.org/3/movie/$movieID/videos?api_key=$apiKey&language=en-US";

    var response = await http.get(url);
    var data = json.decode(response.body);
    return ((data as Map<String, dynamic>)['results'] as List)
        .map((e) => VideosModel(
            key: (e as Map<String, dynamic>)['key'],
            name: (e as Map<String, dynamic>)['name'],
            type: (e as Map<String, dynamic>)['type']))
        .toList();
  }

  ///  Sort Genres Movie
  static Future<List<Movie>> sortGenreMovie(
    int idGenre,
  ) async {
    String url =
        "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&with_genres=$idGenre";
    var response = await http.get(url);
    if (response.statusCode != 200) {
      return [];
    }
    var data = json.decode(response.body);
    List result = data['results'];
    return result.map((e) => Movie.fromJson(e)).toList();
  }
}
