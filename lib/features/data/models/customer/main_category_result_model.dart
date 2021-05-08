class MainCategoryResultModel {
  MainCategoryResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final List<MainCategory>? data;

  factory MainCategoryResultModel.fromJson(Map<String, dynamic> json) =>
      MainCategoryResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<MainCategory>.from(
                json["data"].map((x) => MainCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MainCategory {
  MainCategory({
    required this.id,
    required this.name,
  });

  final id;
  final name;

  factory MainCategory.fromJson(Map<String, dynamic> json) => MainCategory(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
