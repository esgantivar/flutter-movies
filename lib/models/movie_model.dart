class Movies {
  List<Movie> movies = new List();

  Movies();

  Movies.fromJsonList(List<dynamic> ms) {
    if (ms == null) return;
    for (var m in ms) {
      movies.add(Movie.fromJsonMap(m));
    }
  }
}

class Movie {
  String uniqueId;
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Movie({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  Movie.fromJsonMap(Map<String, dynamic> json) {
    popularity = json['popularity'] / 1;
    voteCount = json['vote_count'];
    video = json['video'];
    posterPath = json['poster_path'];
    id = json['id'];
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    title = json['title'];
    voteAverage = json['vote_average'] / 1;
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  String posterImg() {
    return 'http://image.tmdb.org/t/p/w500$posterPath';
  }

  String backgroundImg() {
    return 'http://image.tmdb.org/t/p/w500$backdropPath';
  }
}
