import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_movies/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apiKey = 'dc2cc44bb567f91d1872c37d180942c9';
  String _url = 'api.themoviedb.org';
  String _lang = 'en-US';
  int _pagePopulars = 0;
  List<Movie> _populars = new List();
  final _streamPopulars = StreamController<List<Movie>>.broadcast();
  bool _loading = false;

  Function(List<Movie>) get sinkPopulars => _streamPopulars.sink.add;

  Stream<List<Movie>> get streamPopulars => _streamPopulars.stream;

  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(
        _url, '3/movie/now_playing', {'api_key': _apiKey, 'language': _lang});
    return _processData(url);
  }

  Future<List<Movie>> getPopulars() async {
    if (_loading) return [];
    _loading = true;
    _pagePopulars++;
    final url = Uri.https(_url, '3/movie/popular',
        {'api_key': _apiKey, 'language': _lang, 'page': '$_pagePopulars'});
    final response = await _processData(url);
    _loading = false;
    _populars.addAll(response);
    sinkPopulars(_populars);
    return response;
  }

  Future<List<Movie>> _processData(Uri url) async {
    final response = await http.get(url);
    final data = json.decode(response.body);
    final movies = Movies.fromJsonList(data['results']);
    return movies.movies;
  }

  void disposeStreams() {
    _streamPopulars?.close();
  }
}
