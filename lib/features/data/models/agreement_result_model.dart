// To parse this JSON data, do
//
//     final agreementResultModel = agreementResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class AgreementResultModel {
  AgreementResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final dynamic message;
  final Data data;

  factory AgreementResultModel.fromRawJson(String str) =>
      AgreementResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AgreementResultModel.fromJson(Map<String, dynamic> json) =>
      AgreementResultModel(
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
    @required this.message,
  });

  final String message;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
      };
}
