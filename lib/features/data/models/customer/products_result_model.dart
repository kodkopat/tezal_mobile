// To parse this JSON data, do
//
//     final productsResultModel = productsResultModelFromJson(jsonString);

import 'package:meta/meta.dart';

import 'product_result_model.dart';

class ProductsResultModel {
  ProductsResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final success;
  final message;
  final List<ProductResultModel>? data;

  factory ProductsResultModel.fromJson(Map<String, dynamic> json) =>
      ProductsResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<ProductResultModel>.from(
                json["data"].map(
                  (x) => ProductResultModel.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(
                data!.map(
                  (x) => x.toJson(),
                ),
              ),
      };
}
