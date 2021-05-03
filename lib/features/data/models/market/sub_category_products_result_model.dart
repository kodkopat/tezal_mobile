import 'package:meta/meta.dart';

class SubCategoryProductsResultModel {
  SubCategoryProductsResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final success;
  final message;
  final List<SubCategoryProduct>? data;

  factory SubCategoryProductsResultModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryProductsResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<SubCategoryProduct>.from(
                json["data"].map((x) => SubCategoryProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SubCategoryProduct {
  SubCategoryProduct({
    @required this.id,
    @required this.name,
    @required this.createDate,
    @required this.description,
    @required this.discountedPrice,
    @required this.onSale,
    @required this.originalPrice,
    @required this.productUnit,
    @required this.step,
  });

  final id;
  final name;
  final createDate;
  final description;
  final discountedPrice;
  final onSale;
  final originalPrice;
  final productUnit;
  final step;

  factory SubCategoryProduct.fromJson(Map<String, dynamic> json) =>
      SubCategoryProduct(
        id: json["id"],
        name: json["name"],
        createDate: json["createDate"],
        description: json["description"],
        discountedPrice: json["discountedPrice"],
        onSale: json["onSale"],
        originalPrice: json["originalPrice"],
        productUnit: json["productUnit"],
        step: json["step"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "createDate": createDate,
        "description": description,
        "discountedPrice": discountedPrice,
        "onSale": onSale,
        "originalPrice": originalPrice,
        "productUnit": productUnit,
        "step": step,
      };
}
