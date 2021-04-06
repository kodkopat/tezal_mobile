// To parse this JSON data, do
//
//     final orderDetailResultModel = orderDetailResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

import 'product_result_model.dart';

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
    @required this.marketName,
    @required this.date,
    @required this.totalPrice,
    @required this.status,
    @required this.paymentType,
    @required this.totalDiscount,
    @required this.deliveryCost,
    @required this.items,
  });

  final String id;
  final String marketName;
  final DateTime date;
  final int totalPrice;
  final String status;
  final String paymentType;
  final int totalDiscount;
  final int deliveryCost;
  final List<ProductResultModel> items;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        marketName: json["marketName"] == null ? null : json["marketName"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        totalPrice: json["totalPrice"] == null ? null : json["totalPrice"],
        status: json["status"] == null ? null : json["status"],
        paymentType: json["paymentType"] == null ? null : json["paymentType"],
        totalDiscount:
            json["totalDiscount"] == null ? null : json["totalDiscount"],
        deliveryCost:
            json["deliveryCost"] == null ? null : json["deliveryCost"],
        items: json["items"] == null
            ? null
            : List<ProductResultModel>.from(
                json["items"].map((x) => ProductResultModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "marketName": marketName == null ? null : marketName,
        "date": date == null ? null : date.toIso8601String(),
        "totalPrice": totalPrice == null ? null : totalPrice,
        "status": status == null ? null : status,
        "paymentType": paymentType == null ? null : paymentType,
        "totalDiscount": totalDiscount == null ? null : totalDiscount,
        "deliveryCost": deliveryCost == null ? null : deliveryCost,
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x.toJson())),
      };
}
