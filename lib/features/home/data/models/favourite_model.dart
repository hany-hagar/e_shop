
import 'dart:convert';

import 'package:shop_app/features/home/data/models/product_model.dart';

FavouriteModel favouriteModelFromJson(String str) => FavouriteModel.fromJson(json.decode(str));

String favouriteModelToJson(FavouriteModel data) => json.encode(data.toJson());

class FavouriteModel {
    FavouriteModel({
        required this.status,
        required this.message,
        required this.product,
    });

    bool status;
    String? message;
    ProductModel product;

    factory FavouriteModel.fromJson(Map<dynamic, dynamic> json) => FavouriteModel(
        message: json["message"],
        status: json["status"],
        product: ProductModel.fromJson(json["data"]["product"]),

    );

    Map<dynamic, dynamic> toJson() => {
        "status": status,
    };
}

