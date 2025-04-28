
class ProductModel {
  ProductModel({
    required this.image,
    required this.images,
    required this.price,
    required this.inCart,
    required this.oldPrice,
    required this.inFavorites,
    required this.name,
    required this.discount,
    required this.description,
    required this.id,
    this.dataId, // Nullable int variable
    this.quantity, // Nullable int variable
  });

  String image;
  List<String> images;
  bool inCart;
  bool inFavorites;
  String name;
  String description;
  dynamic discount;
  double oldPrice;
  double price;
  int id;
  int? dataId; // Nullable field
  int? quantity; // Nullable field

  factory ProductModel.fromJson(Map<dynamic, dynamic> json) => ProductModel(
    image: json["image"] ?? "",
    images: json["images"] != null ? List<String>.from(json["images"].map((x) => x)) : [],
    price: (json["price"] ?? 0).toDouble(),
    inCart: json["in_cart"] ?? false,
    oldPrice: (json["old_price"] ?? 0).toDouble(),
    inFavorites: json["in_favorites"] ?? false,
    name: json["name"] ?? "",
    discount: json["discount"] ?? 0,
    description: json["description"] ?? "",
    id: json["id"] ?? 0,
    dataId: json["data_id"]?? 0, // Nullable field
    quantity: json["quantity"] ?? 0, // Nullable field
  );
  factory ProductModel.fromSpecialJson({required Map<dynamic, dynamic> json ,required int dataId,required int quantity}) => ProductModel(
    image: json["image"] ?? "",
    images: json["images"] != null ? List<String>.from(json["images"].map((x) => x)) : [],
    price: (json["price"] ?? 0).toDouble(),
    inCart: json["in_cart"] ?? false,
    oldPrice: (json["old_price"] ?? 0).toDouble(),
    inFavorites: json["in_favorites"] ?? false,
    name: json["name"] ?? "",
    discount: json["discount"] ?? 0,
    description: json["description"] ?? "",
    id: json["id"] ,
    dataId: dataId ,
    quantity: quantity, // Nullable field
// Nullable field
  );

  Map<dynamic, dynamic> toJson() => {
    "image": image,
    "images": List<dynamic>.from(images.map((x) => x)),
    "price": price,
    "in_cart": inCart,
    "old_price": oldPrice,
    "in_favorites": inFavorites,
    "name": name,
    "discount": discount,
    "description": description,
    "id": id,
    "data_id": dataId, // Nullable field
    "quantity": quantity, // Nullable field
  };
}
