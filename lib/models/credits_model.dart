import 'dart:convert';

Credits castFromJson(String str) => Credits.fromJson(json.decode(str));
String castToJson(Credits data) => json.encode(data.toJson());

class Credits {
  Credits({
    required this.id,
    required this.cast,
    required this.crew,
  });

  final int id;
  final List<Cast> cast;
  final List<Crew> crew;

  factory Credits.fromJson(Map<String, dynamic> json) => Credits(
        id: json['id'],
        cast: List<Cast>.from(json['cast'].map((x) => Cast.fromJson(x))),
        crew: List<Crew>.from(json['crew'].map((x) => Crew.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'cast': List<dynamic>.from(cast.map((x) => x.toJson())),
        'crew': List<dynamic>.from(crew.map((x) => x.toJson())),
      };
}

class Crew {
  Crew({
    required this.name,
    required this.profilePath,
    required this.character,
    required this.job,
  });

  final String? name;
  final String? profilePath;
  final String? character;
  final String? job;

  factory Crew.fromJson(Map<String, dynamic> json) => Crew(
        name: json['name'],
        profilePath: json['profile_path'],
        character: json['character'],
        job: json['job'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'profile_path': profilePath,
        'character': character,
        'job': job,
      };
}

class Cast {
  Cast({
    this.name,
    this.profilePath,
    this.character,
  });

  final String? name;
  final String? profilePath;
  final String? character;

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        name: json['name'],
        profilePath: json['profile_path'],
        character: json['character'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'profile_path': profilePath,
        'character': character,
      };
}
