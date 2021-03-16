// To parse this JSON data, do
//
//     final checkSmsResultModel = checkSmsResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class CheckSmsResultModel {
  CheckSmsResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final dynamic message;
  final Data data;

  factory CheckSmsResultModel.fromRawJson(String str) =>
      CheckSmsResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CheckSmsResultModel.fromJson(Map<String, dynamic> json) =>
      CheckSmsResultModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: Data.fromJson(json["data"]) == null
            ? null
            : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data.toJson() == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    @required this.token,
    @required this.name,
    @required this.phone,
  });

  final String token;
  final String name;
  final dynamic phone;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"] == null ? null : json["token"],
        name: json["name"] == null ? null : json["name"],
        phone: json["phone"] == null ? null : json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "token": token == null ? null : token,
        "name": name == null ? null : name,
        "phone": phone == null ? null : phone,
      };
}
