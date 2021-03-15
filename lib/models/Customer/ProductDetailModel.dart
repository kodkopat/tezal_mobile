// To parse this JSON data, do
//
//     final productDetailModel = productDetailModelFromJson(jsonString);

import 'dart:convert';

ProductDetailModel productDetailModelFromJson(String str) =>
    ProductDetailModel.fromJson(json.decode(str));

String productDetailModelToJson(ProductDetailModel data) =>
    json.encode(data.toJson());

class ProductDetailModel {
  ProductDetailModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  dynamic message;
  Data data;

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailModel(
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
    this.marketName,
    this.marketAddress,
    this.basketCount,
    this.liked,
    this.description,
    this.id,
    this.name,
    this.originalPrice,
    this.discountedPrice,
    this.discountRate,
    this.amount,
  });

  String marketName;
  String marketAddress;
  int basketCount;
  bool liked;
  String description;
  String id;
  String name;
  int originalPrice;
  dynamic discountedPrice;
  int discountRate;
  int amount;

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
