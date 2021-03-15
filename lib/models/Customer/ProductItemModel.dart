// To parse this JSON data, do
//
//     final productItemModel = productItemModelFromJson(jsonString);

import 'dart:convert';

ProductItemModel productItemModelFromJson(String str) =>
    ProductItemModel.fromJson(json.decode(str));

String productItemModelToJson(ProductItemModel data) =>
    json.encode(data.toJson());

class ProductItemModel {
  ProductItemModel({
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

  factory ProductItemModel.fromJson(Map<String, dynamic> json) =>
      ProductItemModel(
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
