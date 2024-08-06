import 'package:hive/hive.dart';

part 'wishlist_model.g.dart';

@HiveType(typeId: 0)
class WishMovies {
  @HiveField(0)
  String backdropPath;

  @HiveField(1)
  List<int> genreIds;

  @HiveField(2)
  int id;

  @HiveField(3)
  String originalLanguage;

  @HiveField(4)
  String originalTitle;

  @HiveField(5)
  String overview;

  @HiveField(6)
  String posterPath;

  @HiveField(7)
  DateTime releaseDate;

  @HiveField(8)
  String title;

  WishMovies({
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
  });
}
