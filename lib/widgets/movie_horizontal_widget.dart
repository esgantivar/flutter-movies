import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Movie> movies;
  final _pageController = PageController(initialPage: 1, viewportFraction: 0.3);
  final Function next;

  MovieHorizontal({@required this.movies, @required this.next});

  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        next();
      }
    });
    final _screenSize = MediaQuery.of(context).size;
    return Container(
        height: _screenSize.height * 0.2,
        child: PageView.builder(
          pageSnapping: true,
          controller: _pageController,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return _card(movie: movies[index]);
          },
        ));
  }

  Widget _card({@required Movie movie}) {
    return Container(
        margin: EdgeInsets.only(right: 5.0),
        child: Column(children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                image: NetworkImage(movie.posterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 140,
              )),
          SizedBox(height: 5),
          Text(movie.title, overflow: TextOverflow.ellipsis)
        ]));
  }

  List<Widget> _cards() {
    return movies.map((movie) {
      return _card(movie: movie);
    }).toList();
  }
}
