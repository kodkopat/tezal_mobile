class LikedProductsResultModel {
  LikedProductsResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final data;

  factory LikedProductsResultModel.fromJson(Map<String, dynamic> json) =>
      LikedProductsResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<LikedProduct>.from(
                json["data"].map((x) => LikedProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class LikedProduct {
  LikedProduct({
    required this.id,
    required this.productId,
    required this.category,
    required this.name,
    required this.market,
    required this.marketId,
    required this.photo,
  });

  final id;
  final productId;
  final category;
  final name;
  final market;
  final marketId;
  final List<String>? photo;

  factory LikedProduct.fromJson(Map<String, dynamic> json) => LikedProduct(
        id: json["id"],
        productId: json["productId"],
        category: json["category"],
        name: json["name"],
        market: json["market"],
        marketId: json["marketId"],
        photo: json["photo"] == null
            ? null
            : List<String>.from(json["photo"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "category": category,
        "name": name,
        "market": market,
        "marketId": marketId,
        "photo":
            photo == null ? null : List<dynamic>.from(photo!.map((x) => x)),
      };
}
