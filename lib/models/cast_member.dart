import 'dart:convert';

class Person {
  bool adult;
  List<String> alsoKnownAs;
  String biography;
  DateTime birthday;
  DateTime? deathday;
  int gender;
  String? homepage;
  int id;
  String imdbId;
  String knownForDepartment;
  String name;
  String placeOfBirth;
  double popularity;
  String? profilePath;

  Person({
    required this.adult,
    required this.alsoKnownAs,
    required this.biography,
    required this.birthday,
    required this.deathday,
    required this.gender,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.knownForDepartment,
    required this.name,
    required this.placeOfBirth,
    required this.popularity,
    required this.profilePath,
  });

  Person copyWith({
    bool? adult,
    List<String>? alsoKnownAs,
    String? biography,
    DateTime? birthday,
    DateTime? deathday,
    int? gender,
    String? homepage,
    int? id,
    String? imdbId,
    String? knownForDepartment,
    String? name,
    String? placeOfBirth,
    double? popularity,
    String? profilePath,
  }) =>
      Person(
        adult: adult ?? this.adult,
        alsoKnownAs: alsoKnownAs ?? this.alsoKnownAs,
        biography: biography ?? this.biography,
        birthday: birthday ?? this.birthday,
        deathday: deathday ?? this.deathday,
        gender: gender ?? this.gender,
        homepage: homepage ?? this.homepage,
        id: id ?? this.id,
        imdbId: imdbId ?? this.imdbId,
        knownForDepartment: knownForDepartment ?? this.knownForDepartment,
        name: name ?? this.name,
        placeOfBirth: placeOfBirth ?? this.placeOfBirth,
        popularity: popularity ?? this.popularity,
        profilePath: profilePath ?? this.profilePath,
      );

  factory Person.fromRawJson(String str) => Person.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Person.fromJson(Map<String, dynamic> json) => Person(
    adult: json["adult"] ?? false,
    alsoKnownAs: List<String>.from((json["also_known_as"] ?? []).map((x) => x)),
    biography: json["biography"] ?? "null",
    birthday: DateTime.parse(json["birthday"] ?? DateTime(1970, 1, 1).toIso8601String()),
    deathday: json["deathday"] != null ? DateTime.parse(json["deathday"]) : null,
    gender: json["gender"] ?? 0,
    homepage: json["homepage"] ?? "null",
    id: json["id"] ?? 0,
    imdbId: json["imdb_id"] ?? "null",
    knownForDepartment: json["known_for_department"] ?? "null",
    name: json["name"] ?? "null",
    placeOfBirth: json["place_of_birth"] ?? "null",
    popularity: json["popularity"]?.toDouble() ?? 0.0,
    profilePath: json["profile_path"] ?? "null",
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "also_known_as": List<dynamic>.from(alsoKnownAs.map((x) => x)),
    "biography": biography,
    "birthday": "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
    "deathday": deathday?.toIso8601String() ?? "null",
    "gender": gender,
    "homepage": homepage,
    "id": id,
    "imdb_id": imdbId,
    "known_for_department": knownForDepartment,
    "name": name,
    "place_of_birth": placeOfBirth,
    "popularity": popularity,
    "profile_path": profilePath,
  };
}
