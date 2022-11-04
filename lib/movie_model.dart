class Movie {
  String? name;
  String? genre;
  int? year;
  String? image;

  Movie({this.name, this.genre, this.year, this.image});

  Movie.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    genre = json['genre'];
    year = json['year'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['genre'] = genre;
    data['year'] = year;
    data['image'] = image;
    return data;
  }
}
