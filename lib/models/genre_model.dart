class Genres {
  final int? id;
  final String? name;

  String? error;

  Genres({this.id, this.name});

  factory Genres.fromJson(dynamic json) {
    return Genres(id: json['id'], name: json['name']);
  }
}
