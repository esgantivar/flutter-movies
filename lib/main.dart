import 'package:flutter/material.dart';
import 'package:flutter_movies/pages/home_page.dart';
import 'package:flutter_movies/pages/movie_detail_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'detalle': (BuildContext context) => MovieDetailPage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
