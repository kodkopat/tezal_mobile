class MarketCategoriesResultModel {
  MarketCategoriesResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final data;

  factory MarketCategoriesResultModel.fromJson(Map<String, dynamic> json) =>
      MarketCategoriesResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<MarketCategory>.from(
                json["data"].map((x) => MarketCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MarketCategory {
  MarketCategory({
    required this.categoryId,
    required this.marketId,
    required this.name,
    required this.photo,
  });

  final categoryId;
  final marketId;
  final name;
  final photo;

  factory MarketCategory.fromJson(Map<String, dynamic> json) => MarketCategory(
        categoryId: json["categoryId"],
        marketId: json["marketId"],
        name: json["name"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "marketId": marketId,
        "name": name,
        "photo": photo,
      };
}
