import 'category_model.dart';

class BannerModel {
  BannerModel({
    required this.image,
    required this.id,
    this.category,
  });

  String image;
  int id;
  CategoryModel? category;

  factory BannerModel.fromJson(Map<dynamic, dynamic> json) => BannerModel(
    image: json["image"],
    id: json["id"],
    category: json["category"] == null ? null : CategoryModel.fromJson(json["category"]),
  );

  Map<dynamic, dynamic> toJson() => {
    "image": image,
    "id": id,
    "category": category?.toJson(),
  };
}
