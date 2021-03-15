// To parse this JSON data, do
//
//     final marketDetailModel = marketDetailModelFromJson(jsonString);

import 'dart:convert';

MarketDetailModel marketDetailModelFromJson(String str) =>
    MarketDetailModel.fromJson(json.decode(str));

String marketDetailModelToJson(MarketDetailModel data) =>
    json.encode(data.toJson());

class MarketDetailModel {
  MarketDetailModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  dynamic message;
  Data data;

  factory MarketDetailModel.fromJson(Map<String, dynamic> json) =>
      MarketDetailModel(
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
    this.id,
    this.name,
    this.phone,
    this.address,
    this.location,
    this.score,
    this.distance,
    this.deliveryCost,
    this.basketCount,
    this.categories,
  });

  String id;
  String name;
  dynamic phone;
  String address;
  String location;
  int score;
  double distance;
  int deliveryCost;
  int basketCount;
  List<Category> categories;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        phone: json["phone"],
        address: json["address"] == null ? null : json["address"],
        location: json["location"] == null ? null : json["location"],
        score: json["score"] == null ? null : json["score"],
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
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
    this.id,
    this.name,
    this.products,
  });

  String id;
  String name;
  List<Product> products;

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
    this.id,
    this.name,
    this.liked,
    this.originalPrice,
    this.discountedPrice,
    this.discountRate,
    this.amount,
  });

  String id;
  String name;
  bool liked;
  int originalPrice;
  int discountedPrice;
  int discountRate;
  int amount;

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
