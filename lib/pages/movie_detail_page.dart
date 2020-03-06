import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/models/actor_model.dart';
import 'package:flutter_movies/models/movie_model.dart';
import 'package:flutter_movies/providers/movies_provider.dart';

class MovieDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        _createAppBar(movie),
        SliverList(
            delegate: SliverChildListDelegate([
          SizedBox(height: 10.0),
          _posterTitle(movie, context),
          _description(movie),
          _description(movie),
          _description(movie),
          _description(movie),
          _description(movie),
          _description(movie),
          _description(movie),
          _createCasting(movie)
        ])),
      ],
    ));
  }

  Widget _createAppBar(Movie movie) {
    return SliverAppBar(
        elevation: 2.0,
        backgroundColor: Colors.indigoAccent,
        expandedHeight: 200,
        pinned: true,
        floating: false,
        flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(movie.title),
            background: FadeInImage(
                image: NetworkImage(movie.backgroundImg()),
                placeholder: AssetImage('assets/img/loading.gif'),
                fit: BoxFit.cover)));
  }

  Widget _posterTitle(Movie movie, BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(children: <Widget>[
          Hero(
              tag: movie.uniqueId,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                      image: NetworkImage(movie.posterImg()), height: 160))),
          SizedBox(width: 20),
          Flexible(
              child: Column(children: [
            Text(movie.title, style: Theme.of(context).textTheme.headline6),
            Text(movie.originalTitle,
                style: Theme.of(context).textTheme.subtitle1),
            Row(children: [
              Icon(Icons.star_border),
              Text(movie.voteAverage.toString(),
                  style: Theme.of(context).textTheme.subtitle1)
            ])
          ]))
        ]));
  }

  Widget _description(Movie movie) {
    return Container(
        child: Text(movie.overview, textAlign: TextAlign.justify),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10));
  }

  Widget _createCasting(Movie movie) {
    final provider = new MoviesProvider();

    return FutureBuilder(
      future: provider.getCast(movie.id.toString()),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _createActorsPageView(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _createActorsPageView(List<Actor> actors) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
        itemCount: actors.length,
        itemBuilder: (context, i) => _cardActor(actors[i]),
      ),
    );
  }

  Widget _cardActor(Actor actor) {
    return Container(
        child: Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: FadeInImage(
            image: NetworkImage(actor.getPhoto()),
            placeholder: AssetImage('assets/img/no-image.jpg'),
            height: 150.0,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          actor.name,
          overflow: TextOverflow.ellipsis,
        )
      ],
    ));
  }
}
