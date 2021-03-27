// To parse this JSON data, do
//
//     final productDetailResultModel = productDetailResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class ProductDetailResultModel {
  ProductDetailResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final dynamic message;
  final Data data;

  factory ProductDetailResultModel.fromRawJson(String str) =>
      ProductDetailResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductDetailResultModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailResultModel(
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
    @required this.marketName,
    @required this.marketAddress,
    @required this.basketCount,
    @required this.liked,
    @required this.description,
    @required this.id,
    @required this.name,
    @required this.originalPrice,
    @required this.discountedPrice,
    @required this.discountRate,
    @required this.amount,
  });

  final String marketName;
  final String marketAddress;
  final int basketCount;
  final bool liked;
  final String description;
  final String id;
  final String name;
  final int originalPrice;
  final dynamic discountedPrice;
  final int discountRate;
  final int amount;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        marketName: json["marketName"] == null ? null : json["marketName"],
        marketAddress:
            json["marketAddress"] == null ? null : json["marketAddress"],
        basketCount: json["basketCount"] == null ? null : json["basketCount"],
        liked: json["liked"] == null ? null : json["liked"],
        description: json["description"] == null ? null : json["description"],
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        originalPrice:
            json["originalPrice"] == null ? null : json["originalPrice"],
        discountedPrice: json["discountedPrice"],
        discountRate:
            json["discountRate"] == null ? null : json["discountRate"],
        amount: json["amount"] == null ? null : json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "marketName": marketName == null ? null : marketName,
        "marketAddress": marketAddress == null ? null : marketAddress,
        "basketCount": basketCount == null ? null : basketCount,
        "liked": liked == null ? null : liked,
        "description": description == null ? null : description,
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "originalPrice": originalPrice == null ? null : originalPrice,
        "discountedPrice": discountedPrice,
        "discountRate": discountRate == null ? null : discountRate,
        "amount": amount == null ? null : amount,
      };
}
