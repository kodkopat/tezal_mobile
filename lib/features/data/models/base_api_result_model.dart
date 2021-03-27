// To parse this JSON data, do
//
//     final baseApiResultModel = baseApiResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class BaseApiResultModel {
  BaseApiResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final String message;
  final dynamic data;

  factory BaseApiResultModel.fromRawJson(String str) =>
      BaseApiResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BaseApiResultModel.fromJson(Map<String, dynamic> json) =>
      BaseApiResultModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data,
      };
}
