import 'package:shop_app/features/home/data/models/product_model.dart';

class SearchModel {
    SearchModel({
        required this.data,
        required this.status,
    });

    final Dat? data;
    final bool status;

    factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        data: json["data"] != null ? Dat.fromJson(json["data"]) : null,
        status: json["status"] ?? false,
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "status": status,
    };
}

class Dat {
    Dat({
        required this.firstPageUrl,
        required this.path,
        required this.perPage,
        required this.total,
        required this.products,
        required this.lastPage,
        required this.lastPageUrl,
        required this.from,
        required this.to,
        required this.currentPage,
    });

    final String firstPageUrl;
    final String path;
    final int perPage;
    final int total;
    final List<ProductModel> products;
    final int lastPage;
    final String lastPageUrl;
    final int from;
    final int to;
    final int currentPage;

    factory Dat.fromJson(Map<String, dynamic> json) => Dat(
        firstPageUrl: json["first_page_url"] ?? '',
        path: json["path"] ?? '',
        perPage: json["per_page"] ?? 0,
        total: json["total"] ?? 0,
        products: json["data"] != null
            ? List<ProductModel>.from((json["data"] as List)
            .map((x) => ProductModel.fromJson(x)))
            : [],
        lastPage: json["last_page"] ?? 0,
        lastPageUrl: json["last_page_url"] ?? '',
        from: json["from"] ?? 0,
        to: json["to"] ?? 0,
        currentPage: json["current_page"] ?? 0,
    );

    Map<String, dynamic> toJson() => {
        "first_page_url": firstPageUrl,
        "path": path,
        "per_page": perPage,
        "total": total,
        "data": List<dynamic>.from(products.map((x) => x.toJson())),
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "from": from,
        "to": to,
        "current_page": currentPage,
    };
}
