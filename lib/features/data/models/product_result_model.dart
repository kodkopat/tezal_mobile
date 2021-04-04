// To parse this JSON data, do
//
//     final productResultModel = productResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class ProductResultModel {
  ProductResultModel({
    @required this.id,
    @required this.name,
    @required this.discountedPrice,
    @required this.totalDiscount,
    @required this.originalPrice,
    @required this.liked,
    @required this.discountRate,
    @required this.productUnit,
    @required this.step,
    @required this.amount,
  });

  final id;
  final name;
  final discountedPrice;
  final totalDiscount;
  final originalPrice;
  final liked;
  final discountRate;
  final productUnit;
  final step;
  final amount;

  factory ProductResultModel.fromRawJson(String str) =>
      ProductResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductResultModel.fromJson(Map<String, dynamic> json) =>
      ProductResultModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        discountedPrice:
            json["discountedPrice"] == null ? null : json["discountedPrice"],
        totalDiscount:
            json["totalDiscount"] == null ? null : json["totalDiscount"],
        originalPrice:
            json["originalPrice"] == null ? null : json["originalPrice"],
        liked: json["liked"] == null ? null : json["liked"],
        discountRate: json["discountRate"] == null
            ? null
            : json["discountRate"].toDouble(),
        productUnit: json["productUnit"] == null ? null : json["productUnit"],
        step: json["step"] == null ? null : json["step"],
        amount: json["amount"] == null ? null : json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "discountedPrice": discountedPrice == null ? null : discountedPrice,
        "totalDiscount": totalDiscount == null ? null : totalDiscount,
        "originalPrice": originalPrice == null ? null : originalPrice,
        "liked": liked == null ? null : liked,
        "discountRate": discountRate == null ? null : discountRate,
        "productUnit": productUnit == null ? null : productUnit,
        "step": step == null ? null : step,
        "amount": amount == null ? null : amount,
      };
}
