// To parse this JSON data, do
//
//     final saveAddressResultModel = saveAddressResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class AddressActionsResultModel {
  AddressActionsResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final String message;
  final dynamic data;

  factory AddressActionsResultModel.fromRawJson(String str) =>
      AddressActionsResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddressActionsResultModel.fromJson(Map<String, dynamic> json) =>
      AddressActionsResultModel(
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
