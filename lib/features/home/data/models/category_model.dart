
class CategoryModel {
  CategoryModel({
    required this.image,
    required this.name,
    required this.id,
  });

  String image;
  String name;
  int id;

  factory CategoryModel.fromJson(Map<dynamic, dynamic> json) => CategoryModel(
    image: json["image"],
    name: json["name"],
    id: json["id"],
  );

  Map<dynamic, dynamic> toJson() => {
    "image": image,
    "name": name,
    "id": id,
  };
}
