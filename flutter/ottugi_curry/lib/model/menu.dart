import 'dart:convert';

class MenuModel {
  final String? name;
  final String? thumbnail;
  final String? time;
  final String? difficulty; // 구성 (ex. 든든하게)
  final String? composition;
  final String? ingredients;
  final String? seasoning;
  final String? orders;
  final String? photo;

  //List<String>? ingredients;
  // 생성자
  MenuModel(
      {this.name,
      this.thumbnail,
      this.time,
      this.difficulty,
      this.composition,
      this.ingredients,
      this.seasoning,
      this.orders,
      this.photo});

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
        name: json["name"],
        thumbnail: json["thumbnail"],
        time: json["time"],
        difficulty: json["difficulty"],
        composition: json["composition"],
        ingredients: json["ingredients"],
        seasoning: json["seasoning"],
        orders: json["orders"],
        photo: json["photo"],
        //brand: brandValues.map[json["brand"]]!,
        //tagList: List<dynamic>.from(json["tag_list"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "thumbnail": thumbnail,
        "time": time,
        "difficulty": difficulty,
        "composition": composition,
        "ingredients": ingredients,
        "seasoning": seasoning,
        "orders": orders,
        "photo": photo
      };
}

List<MenuModel> productFromJson(String str) =>
    List<MenuModel>.from(json.decode(str).map((x) => MenuModel.fromJson(x)));

String productToJson(List<MenuModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
