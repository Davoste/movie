import 'dart:convert';

import 'package:goojara/model.dart';
import 'package:http/http.dart' as http;

const apiKey = "d1871aa1d69ced48af92aed1b136e29e";

class APIservices {
  final nowShowingApi =
      "https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey";
  final upComingApi =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey";
  final popularApi =
      "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey";
  final detailsApi = "https://api.themoviedb.org/3/movie/";
  final playMovieApi = "https://api.themoviedb.org/3/movie/";
  final String searchMovieApi = "https://api.themoviedb.org/3/search/";
  //movies now showing
  Future<List<Movie>> getNowShowing() async {
    Uri url = Uri.parse(nowShowingApi);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['results'];
      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception("Failed to load data");
    }
  }

  //up coming
  Future<List<Movie>> getUpComing() async {
    Uri url = Uri.parse(upComingApi);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['results'];
      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception("Failed to load data");
    }
  }

  //popular
  Future<List<Movie>> getPopular() async {
    Uri url = Uri.parse(popularApi);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['results'];
      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception("Failed to load data");
    }
  }

//movie details
  Future<Map<String, dynamic>> details(int movieID) async {
    Uri url = Uri.parse("$detailsApi${movieID.toString()}?api_key=$apiKey");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data; // Directly return the decoded JSON map
    } else {
      throw Exception("Failed to load movie details");
    }
  }

  //play movie
  Future<Map<String, dynamic>> playMovie(int movieID) async {
    Uri url =
        Uri.parse("$playMovieApi${movieID.toString()}/movies?api_key=$apiKey");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data; // Directly return the decoded JSON map
    } else {
      throw Exception("Failed to load movie details");
    }
  }

  //search
  Future<Map<String, dynamic>> searchMovie(String _searchTerm) async {
    Uri url = Uri.parse("$searchMovieApi${_searchTerm}/?api_key=$apiKey");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data; // Directly return the decoded JSON map
    } else {
      throw Exception("Failed to load movie details");
    }
  }
}
