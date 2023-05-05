class Recipe {
  //int? userId;
  int? id;
  String? composition;
  String? difficulty;
  String? ingredients;
  String? name;
  String? thumbnail;
  String? time;
  bool? isBookmark;

  //Recipe({this.id, this.name, this.thumbnail});
  Recipe({this.id, this.name, this.thumbnail, this.difficulty, this.composition, this.ingredients, this.time});

  Recipe.fromJson(Map<String, dynamic> json) {
    //userId = json['userId'];
    id = json['id'];
    composition = json['composition'];
    difficulty = json['difficulty'];
    ingredients = json['ingredients'];
    name = json['name'];
    thumbnail = json['thumbnail'];
    time = json['time'];
    isBookmark = json['isBookmark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    //data['userId'] = this.userId;
    data['id'] = id;
    data['composition'] = composition;
    data['difficulty'] = difficulty;
    data['ingredients'] = ingredients;
    data['name'] = name;
    data['thumbnail'] = thumbnail;
    data['time'] = time;
    data['isBookmark'] = isBookmark;

    return data;
  }
}