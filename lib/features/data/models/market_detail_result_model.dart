// To parse this JSON data, do
//
//     final marketDetailResultModel = marketDetailResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

import 'product_result_model.dart';

class MarketDetailResultModel {
  MarketDetailResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final dynamic message;
  final Data data;

  factory MarketDetailResultModel.fromRawJson(String str) =>
      MarketDetailResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MarketDetailResultModel.fromJson(Map<String, dynamic> json) =>
      MarketDetailResultModel(
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
    @required this.id,
    @required this.address,
    @required this.location,
    @required this.name,
    @required this.phone,
    @required this.score,
    @required this.deliveryCost,
    @required this.distance,
    @required this.categories,
    @required this.basketCount,
  });

  final id;
  final address;
  final location;
  final name;
  final phone;
  final score;
  final deliveryCost;
  final distance;
  final List<Category> categories;
  final basketCount;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        address: json["address"],
        location: json["location"],
        name: json["name"],
        phone: json["phone"],
        score: json["score"],
        deliveryCost: json["deliveryCost"],
        distance: json["distance"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        basketCount: json["basketCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "location": location,
        "name": name,
        "phone": phone,
        "score": score,
        "deliveryCost": deliveryCost,
        "distance": distance,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "basketCount": basketCount,
      };
}

class Category {
  Category({
    @required this.id,
    @required this.name,
    @required this.products,
  });

  final id;
  final name;
  final List<ProductResultModel> products;

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        products: List<ProductResultModel>.from(
            json["products"].map((x) => ProductResultModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}
