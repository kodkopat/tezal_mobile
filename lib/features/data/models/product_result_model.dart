// To parse this JSON data, do
//
//     final produtcResultModel = produtcResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class ProdutcResultModel {
  ProdutcResultModel({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.liked,
    @required this.originalPrice,
    @required this.discountedPrice,
    @required this.discountRate,
    @required this.amount,
  });

  final String id;
  final String name;
  final dynamic description;
  final bool liked;
  final int originalPrice;
  final int discountedPrice;
  final int discountRate;
  final int amount;

  factory ProdutcResultModel.fromRawJson(String str) =>
      ProdutcResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProdutcResultModel.fromJson(Map<String, dynamic> json) =>
      ProdutcResultModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"],
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
        "description": description,
        "liked": liked == null ? null : liked,
        "originalPrice": originalPrice == null ? null : originalPrice,
        "discountedPrice": discountedPrice == null ? null : discountedPrice,
        "discountRate": discountRate == null ? null : discountRate,
        "amount": amount == null ? null : amount,
      };
}
