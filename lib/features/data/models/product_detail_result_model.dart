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
    @required this.subCategoryName,
    @required this.mainCategoryName,
    @required this.subCategoryId,
    @required this.mainCategoryId,
    @required this.marketName,
    @required this.marketAddress,
    @required this.basketCount,
    @required this.liked,
    @required this.description,
    @required this.id,
    @required this.name,
    @required this.originalPrice,
    @required this.discountedPrice,
    @required this.totalDiscount,
    @required this.discountRate,
    @required this.productUnit,
    @required this.step,
    @required this.amount,
  });

  final subCategoryName;
  final mainCategoryName;
  final subCategoryId;
  final mainCategoryId;
  final marketName;
  final marketAddress;
  final basketCount;
  final liked;
  final description;
  final id;
  final name;
  final originalPrice;
  final discountedPrice;
  final totalDiscount;
  final discountRate;
  final productUnit;
  final step;
  final amount;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        subCategoryName:
            json["subCategoryName"] == null ? null : json["subCategoryName"],
        mainCategoryName:
            json["mainCategoryName"] == null ? null : json["mainCategoryName"],
        subCategoryId:
            json["subCategoryId"] == null ? null : json["subCategoryId"],
        mainCategoryId:
            json["mainCategoryId"] == null ? null : json["mainCategoryId"],
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
        discountedPrice:
            json["discountedPrice"] == null ? null : json["discountedPrice"],
        totalDiscount:
            json["totalDiscount"] == null ? null : json["totalDiscount"],
        discountRate: json["discountRate"] == null
            ? null
            : json["discountRate"].toDouble(),
        productUnit: json["productUnit"] == null ? null : json["productUnit"],
        step: json["step"] == null ? null : json["step"],
        amount: json["amount"] == null ? null : json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "subCategoryName": subCategoryName == null ? null : subCategoryName,
        "mainCategoryName": mainCategoryName == null ? null : mainCategoryName,
        "subCategoryId": subCategoryId == null ? null : subCategoryId,
        "mainCategoryId": mainCategoryId == null ? null : mainCategoryId,
        "marketName": marketName == null ? null : marketName,
        "marketAddress": marketAddress == null ? null : marketAddress,
        "basketCount": basketCount == null ? null : basketCount,
        "liked": liked == null ? null : liked,
        "description": description == null ? null : description,
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "originalPrice": originalPrice == null ? null : originalPrice,
        "discountedPrice": discountedPrice == null ? null : discountedPrice,
        "totalDiscount": totalDiscount == null ? null : totalDiscount,
        "discountRate": discountRate == null ? null : discountRate,
        "productUnit": productUnit == null ? null : productUnit,
        "step": step == null ? null : step,
        "amount": amount == null ? null : amount,
      };
}
