import 'package:flutter/material.dart';
import 'package:flutter_movies/providers/movies_provider.dart';
import 'package:flutter_movies/widgets/card_swiper_widget.dart';
import 'package:flutter_movies/widgets/movie_horizontal_widget.dart';

class HomePage extends StatelessWidget {
  final provider = MoviesProvider();

  @override
  Widget build(BuildContext context) {
    provider.getPopulars();
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[_swiperTarjetas(), _footer(context)],
      )),
    );
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: provider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(items: snapshot.data);
        } else {
          return Container(child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Text('Populares'),
            StreamBuilder(
                stream: provider.streamPopulars,
                builder: (BuildContext context,
                    AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.hasData) {
                    return MovieHorizontal(
                        movies: snapshot.data, next: provider.getPopulars);
                  } else {
                    return CircularProgressIndicator();
                  }
                })
          ],
        ));
  }
}
