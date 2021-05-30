class MarketCategoriesResultModel {
  MarketCategoriesResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final List<MarketCategory>? data;

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
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MarketCategory {
  MarketCategory({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory MarketCategory.fromJson(Map<String, dynamic> json) => MarketCategory(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
