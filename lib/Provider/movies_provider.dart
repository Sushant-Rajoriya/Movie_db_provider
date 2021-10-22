import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:movie_db_provider/Data/my_tmdb_api/keys.dart';

class MovieProvider extends ChangeNotifier {
  List _treandingMovies = [];
  List _searchedMovies = [];
  MovieProvider() {
    fatchTrendingMovie();
  }

  List get treandingMovies => _treandingMovies;
  List get searchedMovies => _searchedMovies;

  fatchTrendingMovie() async {
    final trendingResult = await http.get(
      Uri.parse('${Keys.tmDbBasicPath}trending/all/day?api_key=${Keys.apiKey}'),
    );
    _treandingMovies = json.decode(trendingResult.body)['results'];

    notifyListeners();
  }

  searchMovies(String searchTerm) async {
    final searchResult = await http.get(
      Uri.parse(
          '${Keys.tmDbBasicPath}search/movie?api_key=${Keys.apiKey}&query=$searchTerm'),
    );
    _searchedMovies = json.decode(searchResult.body)['results'];
    notifyListeners();
  }
}
