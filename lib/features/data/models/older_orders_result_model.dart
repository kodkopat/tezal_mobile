// To parse this JSON data, do
//
//     final olderOrdersResultModel = olderOrdersResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class OlderOrdersResultModel {
  OlderOrdersResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final dynamic message;
  final List<Order> data;

  factory OlderOrdersResultModel.fromRawJson(String str) =>
      OlderOrdersResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OlderOrdersResultModel.fromJson(Map<String, dynamic> json) =>
      OlderOrdersResultModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<Order>.from(json["data"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Order {
  Order({
    @required this.id,
    @required this.marketName,
    @required this.date,
    @required this.totalPrice,
    @required this.status,
    @required this.paymentType,
  });

  final String id;
  final String marketName;
  final DateTime date;
  final int totalPrice;
  final String status;
  final dynamic paymentType;

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"] == null ? null : json["id"],
        marketName: json["marketName"] == null ? null : json["marketName"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        totalPrice: json["totalPrice"] == null ? null : json["totalPrice"],
        status: json["status"] == null ? null : json["status"],
        paymentType: json["paymentType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "marketName": marketName == null ? null : marketName,
        "date": date == null ? null : date.toIso8601String(),
        "totalPrice": totalPrice == null ? null : totalPrice,
        "status": status == null ? null : status,
        "paymentType": paymentType,
      };
}
