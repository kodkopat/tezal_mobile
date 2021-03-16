// To parse this JSON data, do
//
//     final registerResultModel = registerResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class RegisterResultModel {
  RegisterResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final String message;
  final String data;

  factory RegisterResultModel.fromRawJson(String str) =>
      RegisterResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterResultModel.fromJson(Map<String, dynamic> json) =>
      RegisterResultModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : json["data"],
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null ? null : data,
      };
}
