// To parse this JSON data, do
//
//     final basketResultModel = basketResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class BasketResultModel {
  BasketResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final dynamic message;
  final Data data;

  factory BasketResultModel.fromRawJson(String str) =>
      BasketResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BasketResultModel.fromJson(Map<String, dynamic> json) =>
      BasketResultModel(
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
    @required this.marketId,
    @required this.marketName,
    @required this.totalPrice,
    @required this.totalDiscountedPrice,
    @required this.totalDiscount,
    @required this.deliveryCost,
    @required this.payable,
    @required this.note,
    @required this.items,
  });

  final String marketId;
  final String marketName;
  final int totalPrice;
  final int totalDiscountedPrice;
  final int totalDiscount;
  final int deliveryCost;
  final int payable;
  final dynamic note;
  final List<BasketItem> items;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        marketId: json["marketId"] == null ? null : json["marketId"],
        marketName: json["marketName"] == null ? null : json["marketName"],
        totalPrice: json["totalPrice"] == null ? null : json["totalPrice"],
        totalDiscountedPrice: json["totalDiscountedPrice"] == null
            ? null
            : json["totalDiscountedPrice"],
        totalDiscount:
            json["totalDiscount"] == null ? null : json["totalDiscount"],
        deliveryCost:
            json["deliveryCost"] == null ? null : json["deliveryCost"],
        payable: json["payable"] == null ? null : json["payable"],
        note: json["note"],
        items: json["items"] == null
            ? null
            : List<BasketItem>.from(
                json["items"].map((x) => BasketItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "marketId": marketId == null ? null : marketId,
        "marketName": marketName == null ? null : marketName,
        "totalPrice": totalPrice == null ? null : totalPrice,
        "totalDiscountedPrice":
            totalDiscountedPrice == null ? null : totalDiscountedPrice,
        "totalDiscount": totalDiscount == null ? null : totalDiscount,
        "deliveryCost": deliveryCost == null ? null : deliveryCost,
        "payable": payable == null ? null : payable,
        "note": note,
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class BasketItem {
  BasketItem({
    @required this.id,
    @required this.productName,
    @required this.originalPrice,
    @required this.discountedPrice,
    @required this.totalDiscountedPrice,
    @required this.totalDiscount,
    @required this.totalPrice,
    @required this.payablePrice,
    @required this.productUnit,
    @required this.step,
    @required this.amount,
  });

  final id;
  final productName;
  final originalPrice;
  final discountedPrice;
  final totalDiscountedPrice;
  final totalDiscount;
  final totalPrice;
  final payablePrice;
  final productUnit;
  final step;
  final amount;

  factory BasketItem.fromRawJson(String str) =>
      BasketItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BasketItem.fromJson(Map<String, dynamic> json) => BasketItem(
        id: json["id"] == null ? null : json["id"],
        productName: json["productName"] == null ? null : json["productName"],
        originalPrice:
            json["originalPrice"] == null ? null : json["originalPrice"],
        discountedPrice:
            json["discountedPrice"] == null ? null : json["discountedPrice"],
        totalDiscountedPrice: json["totalDiscountedPrice"] == null
            ? null
            : json["totalDiscountedPrice"],
        totalDiscount:
            json["totalDiscount"] == null ? null : json["totalDiscount"],
        totalPrice: json["totalPrice"] == null ? null : json["totalPrice"],
        payablePrice:
            json["payablePrice"] == null ? null : json["payablePrice"],
        productUnit: json["productUnit"] == null ? null : json["productUnit"],
        step: json["step"] == null ? null : json["step"],
        amount: json["amount"] == null ? null : json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "productName": productName == null ? null : productName,
        "originalPrice": originalPrice == null ? null : originalPrice,
        "discountedPrice": discountedPrice == null ? null : discountedPrice,
        "totalDiscountedPrice":
            totalDiscountedPrice == null ? null : totalDiscountedPrice,
        "totalDiscount": totalDiscount == null ? null : totalDiscount,
        "totalPrice": totalPrice == null ? null : totalPrice,
        "payablePrice": payablePrice == null ? null : payablePrice,
        "productUnit": productUnit == null ? null : productUnit,
        "step": step == null ? null : step,
        "amount": amount == null ? null : amount,
      };
}
