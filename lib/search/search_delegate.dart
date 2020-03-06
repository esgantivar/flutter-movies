import 'package:flutter/material.dart';
import 'package:flutter_movies/models/movie_model.dart';
import 'package:flutter_movies/providers/movies_provider.dart';

class DataSearch extends SearchDelegate {
  String seleccion = '';
  final provider = new MoviesProvider();

  final recentMovies = ['Spiderman', 'Capitan America'];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: provider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data;
          return ListView(
              children: movies.map((Movie movie) {
            return ListTile(
              leading: FadeInImage(
                image: NetworkImage(movie.posterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                width: 50.0,
                fit: BoxFit.contain,
              ),
              title: Text(movie.title),
              subtitle: Text(movie.originalTitle),
              onTap: () {
                close(context, null);
                movie.uniqueId = '';
                Navigator.pushNamed(context, 'detalle', arguments: movie);
              },
            );
          }).toList());
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
