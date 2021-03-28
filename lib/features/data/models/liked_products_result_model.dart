// To parse this JSON data, do
//
//     final likedProductsResultModel = likedProductsResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class LikedProductsResultModel {
  LikedProductsResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final dynamic message;
  final List<LikedProduct> data;

  factory LikedProductsResultModel.fromRawJson(String str) =>
      LikedProductsResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LikedProductsResultModel.fromJson(Map<String, dynamic> json) =>
      LikedProductsResultModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<LikedProduct>.from(
                json["data"].map((x) => LikedProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class LikedProduct {
  LikedProduct({
    @required this.id,
    @required this.name,
    @required this.category,
  });

  final String id;
  final String name;
  final String category;

  factory LikedProduct.fromRawJson(String str) =>
      LikedProduct.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LikedProduct.fromJson(Map<String, dynamic> json) => LikedProduct(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        category: json["category"] == null ? null : json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "category": category == null ? null : category,
      };
}
