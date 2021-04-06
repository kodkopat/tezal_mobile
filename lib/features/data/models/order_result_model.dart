// To parse this JSON data, do
//
//     final orderResultModel = orderResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class OrderResultModel {
  OrderResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final dynamic message;
  final Data data;

  factory OrderResultModel.fromRawJson(String str) =>
      OrderResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderResultModel.fromJson(Map<String, dynamic> json) =>
      OrderResultModel(
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
    @required this.paymentType,
    @required this.orderId,
  });

  final int paymentType;
  final String orderId;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        paymentType: json["paymentType"] == null ? null : json["paymentType"],
        orderId: json["orderId"] == null ? null : json["orderId"],
      );

  Map<String, dynamic> toJson() => {
        "paymentType": paymentType == null ? null : paymentType,
        "orderId": orderId == null ? null : orderId,
      };
}
