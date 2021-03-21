// To parse this JSON data, do
//
//     final marketDetailResultModel = marketDetailResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

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
    @required this.name,
    @required this.phone,
    @required this.address,
    @required this.location,
    @required this.score,
    @required this.distance,
    @required this.deliveryCost,
    @required this.basketCount,
    @required this.categories,
  });

  final String id;
  final String name;
  final dynamic phone;
  final String address;
  final String location;
  final int score;
  final int distance;
  final int deliveryCost;
  final int basketCount;
  final List<Category> categories;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        phone: json["phone"],
        address: json["address"] == null ? null : json["address"],
        location: json["location"] == null ? null : json["location"],
        score: json["score"] == null ? null : json["score"],
        distance: json["distance"] == null ? null : json["distance"],
        deliveryCost:
            json["deliveryCost"] == null ? null : json["deliveryCost"],
        basketCount: json["basketCount"] == null ? null : json["basketCount"],
        categories: json["categories"] == null
            ? null
            : List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "phone": phone,
        "address": address == null ? null : address,
        "location": location == null ? null : location,
        "score": score == null ? null : score,
        "distance": distance == null ? null : distance,
        "deliveryCost": deliveryCost == null ? null : deliveryCost,
        "basketCount": basketCount == null ? null : basketCount,
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories.map((x) => x.toJson())),
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
  final List<Product> products;

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        products: json["products"] == null
            ? null
            : List<Product>.from(
                json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "products": products == null
            ? null
            : List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    @required this.id,
    @required this.name,
    @required this.liked,
    @required this.originalPrice,
    @required this.discountedPrice,
    @required this.discountRate,
    @required this.amount,
  });

  final String id;
  final String name;
  final bool liked;
  final int originalPrice;
  final int discountedPrice;
  final int discountRate;
  final int amount;

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        liked: json["liked"] == null ? null : json["liked"],
        originalPrice:
            json["originalPrice"] == null ? null : json["originalPrice"],
        discountedPrice:
            json["discountedPrice"] == null ? null : json["discountedPrice"],
        discountRate:
            json["discountRate"] == null ? null : json["discountRate"],
        amount: json["amount"] == null ? null : json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "liked": liked == null ? null : liked,
        "originalPrice": originalPrice == null ? null : originalPrice,
        "discountedPrice": discountedPrice == null ? null : discountedPrice,
        "discountRate": discountRate == null ? null : discountRate,
        "amount": amount == null ? null : amount,
      };
}
