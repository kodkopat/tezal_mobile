// To parse this JSON data, do
//
//     final allProductsResultModel = allProductsResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class AllProductsResultModel {
  AllProductsResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final dynamic message;
  final List<Datum> data;

  factory AllProductsResultModel.fromRawJson(String str) =>
      AllProductsResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllProductsResultModel.fromJson(Map<String, dynamic> json) =>
      AllProductsResultModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    @required this.subCategoryName,
    @required this.mainCategoryName,
    @required this.subCategoryId,
    @required this.mainCategoryId,
    @required this.id,
    @required this.name,
    @required this.discountedPrice,
    @required this.originalPrice,
    @required this.discountRate,
    @required this.amount,
  });

  final String subCategoryName;
  final String mainCategoryName;
  final String subCategoryId;
  final String mainCategoryId;
  final String id;
  final String name;
  final int discountedPrice;
  final int originalPrice;
  final int discountRate;
  final int amount;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        subCategoryName:
            json["subCategoryName"] == null ? null : json["subCategoryName"],
        mainCategoryName:
            json["mainCategoryName"] == null ? null : json["mainCategoryName"],
        subCategoryId:
            json["subCategoryId"] == null ? null : json["subCategoryId"],
        mainCategoryId:
            json["mainCategoryId"] == null ? null : json["mainCategoryId"],
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        discountedPrice:
            json["discountedPrice"] == null ? null : json["discountedPrice"],
        originalPrice:
            json["originalPrice"] == null ? null : json["originalPrice"],
        discountRate:
            json["discountRate"] == null ? null : json["discountRate"],
        amount: json["amount"] == null ? null : json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "subCategoryName": subCategoryName == null ? null : subCategoryName,
        "mainCategoryName": mainCategoryName == null ? null : mainCategoryName,
        "subCategoryId": subCategoryId == null ? null : subCategoryId,
        "mainCategoryId": mainCategoryId == null ? null : mainCategoryId,
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "discountedPrice": discountedPrice == null ? null : discountedPrice,
        "originalPrice": originalPrice == null ? null : originalPrice,
        "discountRate": discountRate == null ? null : discountRate,
        "amount": amount == null ? null : amount,
      };
}
