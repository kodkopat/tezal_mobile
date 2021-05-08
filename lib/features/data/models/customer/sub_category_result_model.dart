class SubCategoryResultModel {
  SubCategoryResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final List<SubCategory>? data;

  factory SubCategoryResultModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<SubCategory>.from(
                json["data"].map((x) => SubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SubCategory {
  SubCategory({
    required this.id,
    required this.name,
  });

  final id;
  final name;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
