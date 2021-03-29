// To parse this JSON data, do
//
//     final marketCategoriesResultModel = marketCategoriesResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class MarketCategoriesResultModel {
  MarketCategoriesResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final dynamic message;
  final List<MarketCategory> data;

  factory MarketCategoriesResultModel.fromRawJson(String str) =>
      MarketCategoriesResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MarketCategoriesResultModel.fromJson(Map<String, dynamic> json) =>
      MarketCategoriesResultModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<MarketCategory>.from(
                json["data"].map((x) => MarketCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MarketCategory {
  MarketCategory({
    @required this.categoryId,
    @required this.marketId,
    @required this.name,
    @required this.photo,
  });

  final String categoryId;
  final String marketId;
  final String name;
  final String photo;

  factory MarketCategory.fromRawJson(String str) =>
      MarketCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MarketCategory.fromJson(Map<String, dynamic> json) => MarketCategory(
        categoryId: json["categoryId"] == null ? null : json["categoryId"],
        marketId: json["marketId"] == null ? null : json["marketId"],
        name: json["name"] == null ? null : json["name"],
        photo: json["photo"] == null ? null : json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId == null ? null : categoryId,
        "marketId": marketId == null ? null : marketId,
        "name": name == null ? null : name,
        "photo": photo == null ? null : photo,
      };
}
