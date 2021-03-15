// To parse this JSON data, do
//
//     final productResponseModel = productResponseModelFromJson(jsonString);

import 'dart:convert';

ProductResponseModel productResponseModelFromJson(String str) =>
    ProductResponseModel.fromJson(json.decode(str));

String productResponseModelToJson(ProductResponseModel data) =>
    json.encode(data.toJson());

class ProductResponseModel {
  ProductResponseModel({
    this.data,
    this.page,
    this.count,
  });

  List<Product> data;
  int page;
  int count;

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) =>
      ProductResponseModel(
        data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
        page: json["page"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "page": page,
        "count": count,
      };
}

class Product {
  Product({
    this.id,
    this.createDate,
    this.name,
    this.description,
    this.discountedPrice,
    this.originalPrice,
    this.productPhoto,
  });

  String id;
  DateTime createDate;
  String name;
  String description;
  String discountedPrice;
  String originalPrice;
  List<String> productPhoto;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        createDate: DateTime.parse(json["createDate"]),
        name: json["name"],
        description: json["description"],
        discountedPrice:
            json["discountedPrice"] == null ? null : json["discountedPrice"],
        originalPrice: json["originalPrice"],
        productPhoto: List<String>.from(json["productPhoto"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createDate": createDate.toIso8601String(),
        "name": name,
        "description": description,
        "discountedPrice": discountedPrice == null ? null : discountedPrice,
        "originalPrice": originalPrice,
        "productPhoto": List<dynamic>.from(productPhoto.map((x) => x)),
      };
}
