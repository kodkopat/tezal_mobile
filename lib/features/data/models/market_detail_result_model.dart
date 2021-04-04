// To parse this JSON data, do
//
//     final marketDetailResultModel = marketDetailResultModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

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
        success: json["success"] == null ? null : json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message,
        "data": data == null ? null : data.toJson(),
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
    @required this.openAt,
    @required this.clouseAt,
    @required this.situation,
    @required this.deliveryCost,
    @required this.distance,
    @required this.categories,
    @required this.basketCount,
  });

  final String id;
  final String address;
  final String location;
  final String name;
  final dynamic phone;
  final int score;
  final int openAt;
  final int clouseAt;
  final String situation;
  final int deliveryCost;
  final int distance;
  final List<Category> categories;
  final int basketCount;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        address: json["address"] == null ? null : json["address"],
        location: json["location"] == null ? null : json["location"],
        name: json["name"] == null ? null : json["name"],
        phone: json["phone"],
        score: json["score"] == null ? null : json["score"],
        openAt: json["openAt"] == null ? null : json["openAt"],
        clouseAt: json["clouseAt"] == null ? null : json["clouseAt"],
        situation: json["situation"] == null ? null : json["situation"],
        deliveryCost:
            json["deliveryCost"] == null ? null : json["deliveryCost"],
        distance: json["distance"] == null ? null : json["distance"],
        categories: json["categories"] == null
            ? null
            : List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x))),
        basketCount: json["basketCount"] == null ? null : json["basketCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "address": address == null ? null : address,
        "location": location == null ? null : location,
        "name": name == null ? null : name,
        "phone": phone,
        "score": score == null ? null : score,
        "openAt": openAt == null ? null : openAt,
        "clouseAt": clouseAt == null ? null : clouseAt,
        "situation": situation == null ? null : situation,
        "deliveryCost": deliveryCost == null ? null : deliveryCost,
        "distance": distance == null ? null : distance,
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories.map((x) => x.toJson())),
        "basketCount": basketCount == null ? null : basketCount,
      };
}

class Category {
  Category({
    @required this.id,
    @required this.name,
    @required this.products,
  });

  final String id;
  final String name;
  final List<ProductResultModel> products;

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        products: json["products"] == null
            ? null
            : List<ProductResultModel>.from(
                json["products"].map((x) => ProductResultModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "products": products == null
            ? null
            : List<dynamic>.from(products.map((x) => x.toJson())),
      };
}
