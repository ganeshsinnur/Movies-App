import 'dart:convert';

class Cast {
  int id;
  List<CastElement> cast;
  List<CastElement> crew;

  Cast({
    required this.id,
    required this.cast,
    required this.crew,
  });

  Cast copyWith({
    int? id,
    List<CastElement>? cast,
    List<CastElement>? crew,
  }) =>
      Cast(
        id: id ?? this.id,
        cast: cast ?? this.cast,
        crew: crew ?? this.crew,
      );

  factory Cast.fromRawJson(String str) => Cast.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
    id: json["id"] ?? 0,
    cast: List<CastElement>.from(
        (json["cast"] ?? []).map((x) => CastElement.fromJson(x))),
    crew: List<CastElement>.from(
        (json["crew"] ?? []).map((x) => CastElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
    "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
  };
}
class CastElement {
  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String? profilePath;
  int? castId;
  String? character;
  String creditId;
  int? order;
  String? department;
  String? job;

  CastElement({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    required this.creditId,
    this.order,
    this.department,
    this.job,
  });

  CastElement copyWith({
    bool? adult,
    int? gender,
    int? id,
    String? knownForDepartment,
    String? name,
    String? originalName,
    double? popularity,
    String? profilePath,
    int? castId,
    String? character,
    String? creditId,
    int? order,
    String? department,
    String? job,
  }) =>
      CastElement(
        adult: adult ?? this.adult,
        gender: gender ?? this.gender,
        id: id ?? this.id,
        knownForDepartment: knownForDepartment ?? this.knownForDepartment,
        name: name ?? this.name,
        originalName: originalName ?? this.originalName,
        popularity: popularity ?? this.popularity,
        profilePath: profilePath ?? this.profilePath,
        castId: castId ?? this.castId,
        character: character ?? this.character,
        creditId: creditId ?? this.creditId,
        order: order ?? this.order,
        department: department ?? this.department,
        job: job ?? this.job,
      );

  factory CastElement.fromRawJson(String str) => CastElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CastElement.fromJson(Map<String, dynamic> json) => CastElement(
    adult: json["adult"] ?? false,
    gender: json["gender"] ?? 0,
    id: json["id"] ?? 0,
    knownForDepartment: json["known_for_department"] ?? "null",
    name: json["name"] ?? "null",
    originalName: json["original_name"] ?? "null",
    popularity: (json["popularity"] ?? 0.0).toDouble(),
    profilePath: json["profile_path"] ?? "null",
    castId: json["cast_id"],
    character: json["character"] ?? "null",
    creditId: json["credit_id"] ?? "null",
    order: json["order"],
    department: json["department"] ?? "null",
    job: json["job"] ?? "null",
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "gender": gender,
    "id": id,
    "known_for_department": knownForDepartment,
    "name": name,
    "original_name": originalName,
    "popularity": popularity,
    "profile_path": profilePath ?? "null",
    "cast_id": castId ?? "null",
    "character": character ?? "null",
    "credit_id": creditId,
    "order": order ?? "null",
    "department": department ?? "null",
    "job": job ?? "null",
  };
}
