class WishlistMovies {
  String backdropPath;
  int id;
  String originalTitle;
  String posterPath;
  DateTime releaseDate;
  String title;

  WishlistMovies({
    required this.backdropPath,
    required this.id,
    required this.originalTitle,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
  });

  Map<String, dynamic> toJson() => {
    'backdropPath': backdropPath,
    'id': id,
    'originalTitle': originalTitle,
    'posterPath': posterPath,
    'releaseDate': releaseDate.toIso8601String(),
    'title': title,
  };

  factory WishlistMovies.fromJson(Map<String, dynamic> json) {
    return WishlistMovies(
      backdropPath: json['backdropPath'],
      id: json['id'],
      originalTitle: json['originalTitle'],
      posterPath: json['posterPath'],
      releaseDate: DateTime.parse(json['releaseDate']),
      title: json['title'],
    );
  }
}
