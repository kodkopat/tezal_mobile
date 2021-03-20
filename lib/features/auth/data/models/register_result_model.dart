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
  final Data data;

  factory RegisterResultModel.fromRawJson(String str) =>
      RegisterResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterResultModel.fromJson(Map<String, dynamic> json) =>
      RegisterResultModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    @required this.userId,
  });

  final String userId;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["userId"] == null ? null : json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId == null ? null : userId,
      };
}
