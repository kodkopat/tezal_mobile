// To parse this JSON data, do
//
//     final basketCountResultModel = basketCountResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class BasketCountResultModel {
  BasketCountResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final dynamic message;
  final int data;

  factory BasketCountResultModel.fromRawJson(String str) =>
      BasketCountResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BasketCountResultModel.fromJson(Map<String, dynamic> json) =>
      BasketCountResultModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"],
        data: json["data"] == null ? null : json["data"],
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message,
        "data": data == null ? null : data,
      };
}
