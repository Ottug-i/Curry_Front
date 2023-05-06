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
}
