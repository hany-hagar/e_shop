import 'package:shop_app/features/home/data/models/product_model.dart';

class CartModel {
    CartModel({
        this.data, // Nullable
        this.message, // Nullable
        required this.status,
    });

    Data? data;
    String? message;
    bool status;

    factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
        message: json["message"],
        status: json["status"],
    );
    factory CartModel.addFromJson(Map<String, dynamic> json) => CartModel(
        data: json["data"] != null ? Data.addFromJson(json["data"]) : null,
        message: json["message"],
        status: json["status"],
    );
    factory CartModel.updateFromJson(Map<String, dynamic> json) => CartModel(
        data: json["data"] != null ? Data.updateFromJson(json["data"]) : null,
        message: json["message"],
        status: json["status"],
    );
}

class Data {
    Data({
        this.total, // Nullable
        this.subTotal, // Nullable
        this.products,
        this.product, // Nullable
    });

    int? total;
    int? subTotal;
    List<ProductModel>? products;
    ProductModel? product;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        total: json.containsKey("total") ? json["total"] : null,
        subTotal: json.containsKey("sub_total") ? json["sub_total"] : null,
        product: null,
        products: (json["cart_items"] as List<dynamic>?)?.map((item) => ProductModel.fromSpecialJson(json:item["product"],dataId:item["id"],quantity: item["quantity"]  )).toList() ?? [], // Handle empty lists gracefully
    );
    factory Data.addFromJson(Map<String, dynamic> json) => Data(
        total: json.containsKey("total") ? json["total"] : null,
        subTotal: json.containsKey("sub_total") ? json["sub_total"] : null,
        product: ProductModel.fromSpecialJson(json: json['product'], dataId: json['id'], quantity: json['quantity']) ,
        products: []
    );
    factory Data.updateFromJson(Map<String, dynamic> json) => Data(
        total: json.containsKey("total") ? json["total"] : null,
        subTotal: json.containsKey("sub_total") ? json["sub_total"] : null,
        product: ProductModel.fromSpecialJson(json: json['cart']['product'], dataId: json['cart']['id'], quantity: json["cart"]['quantity']) ,
        products: []
    );

}

