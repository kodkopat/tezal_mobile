import 'dart:convert';

import 'product_result_model.dart';

class SubCategoryDetailResultModel {
  SubCategoryDetailResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final data;

  factory SubCategoryDetailResultModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryDetailResultModel(
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
    required this.categoryName,
    required this.categoryId,
    required this.products,
  });

  final categoryName;
  final categoryId;
  final products;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        categoryName: json["categoryName"],
        categoryId: json["categoryId"],
        products: List<ProductResultModel>.from(
            json["products"].map((x) => ProductResultModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categoryName": categoryName,
        "categoryId": categoryId,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}
