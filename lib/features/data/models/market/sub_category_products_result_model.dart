import 'package:meta/meta.dart';

import 'product_result_model.dart';

class SubCategoryProductsResultModel {
  SubCategoryProductsResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final success;
  final message;
  final List<ProductResultModel>? data;

  factory SubCategoryProductsResultModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryProductsResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<ProductResultModel>.from(
                json["data"].map((x) => ProductResultModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
