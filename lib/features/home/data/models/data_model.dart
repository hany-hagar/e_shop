
import 'banner_model.dart';
import 'product_model.dart';

class DataModel {
  DataModel({
    required this.ad,
    required this.banners,
    required this.products,
  });

  String ad;
  List<BannerModel> banners;
  List<ProductModel> products;

  factory DataModel.fromJson(Map<dynamic, dynamic> json) => DataModel(
    ad: json["ad"],
    banners: List<BannerModel>.from(json["banners"].map((x) => BannerModel.fromJson(x))),
    products: List<ProductModel>.from(json["products"].map((x) => ProductModel.fromJson(x))),
  );

  Map<dynamic, dynamic> toJson() => {
    "ad": ad,
    "banners": List<dynamic>.from(banners.map((x) => x.toJson())),
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}
