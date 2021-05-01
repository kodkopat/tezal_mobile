import 'package:meta/meta.dart';

import 'product_result_model.dart';

class MainCategoryDetailResultModel {
  MainCategoryDetailResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final success;
  final message;
  final data;

  factory MainCategoryDetailResultModel.fromJson(Map<String, dynamic> json) =>
      MainCategoryDetailResultModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    @required this.categoryName,
    @required this.categoryId,
    @required this.subCategories,
  });

  final categoryName;
  final categoryId;
  final subCategories;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        categoryName: json["categoryName"],
        categoryId: json["categoryId"],
        subCategories: List<SubCategory>.from(
            json["subCategories"].map((x) => SubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categoryName": categoryName,
        "categoryId": categoryId,
        "subCategories":
            List<dynamic>.from(subCategories.map((x) => x.toJson())),
      };
}

class SubCategory {
  SubCategory({
    @required this.subCategoryName,
    @required this.subCategoryId,
    @required this.products,
  });

  final subCategoryName;
  final subCategoryId;
  final products;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        subCategoryName: json["subCategoryName"],
        subCategoryId: json["subCategoryId"],
        products: List<ProductResultModel>.from(
            json["products"].map((x) => ProductResultModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "subCategoryName": subCategoryName,
        "subCategoryId": subCategoryId,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}
