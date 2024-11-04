class Movie {
  final String title;
  final String backDropPath;
  final String posterPath;
  final String overview;
  final int movieID;

  Movie({
    required this.backDropPath,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.movieID,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      backDropPath: map['backdrop_path'],
      title: map['title'],
      posterPath: map['poster_path'],
      overview: map['overview'],
      movieID: map['id'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'backdrop': backDropPath,
      'poster': posterPath,
      'overview': overview,
      'movieID': movieID,
    };
  }
}
