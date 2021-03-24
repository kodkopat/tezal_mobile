// To parse this JSON data, do
//
//     final clearSearchTermsResultModel = clearSearchTermsResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class ClearSearchTermsResultModel {
  ClearSearchTermsResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final String message;
  final dynamic data;

  factory ClearSearchTermsResultModel.fromRawJson(String str) =>
      ClearSearchTermsResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClearSearchTermsResultModel.fromJson(Map<String, dynamic> json) =>
      ClearSearchTermsResultModel(
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
