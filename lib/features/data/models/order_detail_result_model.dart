// To parse this JSON data, do
//
//     final orderDetailResultModel = orderDetailResultModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class OrderDetailResultModel {
  OrderDetailResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final dynamic message;
  final Data data;

  factory OrderDetailResultModel.fromRawJson(String str) =>
      OrderDetailResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderDetailResultModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailResultModel(
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
    @required this.date,
    @required this.deliveryCost,
    @required this.marketName,
    @required this.paymentType,
    @required this.status,
    @required this.totalDiscount,
    @required this.totalPrice,
    @required this.items,
  });

  final String id;
  final String date;
  final int deliveryCost;
  final String marketName;
  final String paymentType;
  final String status;
  final int totalDiscount;
  final int totalPrice;
  final List<OrderItem> items;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        date: json["date"] == null ? null : json["date"],
        deliveryCost:
            json["deliveryCost"] == null ? null : json["deliveryCost"],
        marketName: json["marketName"] == null ? null : json["marketName"],
        paymentType: json["paymentType"] == null ? null : json["paymentType"],
        status: json["status"] == null ? null : json["status"],
        totalDiscount:
            json["totalDiscount"] == null ? null : json["totalDiscount"],
        totalPrice: json["totalPrice"] == null ? null : json["totalPrice"],
        items: json["items"] == null
            ? null
            : List<OrderItem>.from(
                json["items"].map((x) => OrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "date": date == null ? null : date,
        "deliveryCost": deliveryCost == null ? null : deliveryCost,
        "marketName": marketName == null ? null : marketName,
        "paymentType": paymentType == null ? null : paymentType,
        "status": status == null ? null : status,
        "totalDiscount": totalDiscount == null ? null : totalDiscount,
        "totalPrice": totalPrice == null ? null : totalPrice,
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class OrderItem {
  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.productName,
    @required this.originalPrice,
    @required this.discountedPrice,
    @required this.totalDiscount,
    @required this.totalPrice,
    @required this.payablePrice,
    @required this.totalDiscountedPrice,
    @required this.step,
    @required this.productUnit,
  });

  final String id;
  final int amount;
  final String productName;
  final int originalPrice;
  final int discountedPrice;
  final int totalDiscount;
  final int totalPrice;
  final int payablePrice;
  final int totalDiscountedPrice;
  final double step;
  final String productUnit;

  factory OrderItem.fromRawJson(String str) => OrderItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"] == null ? null : json["id"],
        amount: json["amount"] == null ? null : json["amount"],
        productName: json["productName"] == null ? null : json["productName"],
        originalPrice:
            json["originalPrice"] == null ? null : json["originalPrice"],
        discountedPrice:
            json["discountedPrice"] == null ? null : json["discountedPrice"],
        totalDiscount:
            json["totalDiscount"] == null ? null : json["totalDiscount"],
        totalPrice: json["totalPrice"] == null ? null : json["totalPrice"],
        payablePrice:
            json["payablePrice"] == null ? null : json["payablePrice"],
        totalDiscountedPrice: json["totalDiscountedPrice"] == null
            ? null
            : json["totalDiscountedPrice"],
        step: json["step"] == null ? null : json["step"].toDouble(),
        productUnit: json["productUnit"] == null ? null : json["productUnit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "amount": amount == null ? null : amount,
        "productName": productName == null ? null : productName,
        "originalPrice": originalPrice == null ? null : originalPrice,
        "discountedPrice": discountedPrice == null ? null : discountedPrice,
        "totalDiscount": totalDiscount == null ? null : totalDiscount,
        "totalPrice": totalPrice == null ? null : totalPrice,
        "payablePrice": payablePrice == null ? null : payablePrice,
        "totalDiscountedPrice":
            totalDiscountedPrice == null ? null : totalDiscountedPrice,
        "step": step == null ? null : step,
        "productUnit": productUnit == null ? null : productUnit,
      };
}
