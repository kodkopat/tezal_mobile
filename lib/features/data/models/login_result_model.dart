// To parse this JSON data, do
//
//     final loginResultModel = loginResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class LoginResultModel {
  LoginResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final dynamic message;
  final Data data;

  factory LoginResultModel.fromRawJson(String str) =>
      LoginResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResultModel.fromJson(Map<String, dynamic> json) =>
      LoginResultModel(
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
    @required this.name,
    @required this.type,
    @required this.token,
  });

  final String name;
  final String type;
  final String token;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
        token: json["token"] == null ? null : json["token"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "type": type == null ? null : type,
        "token": token == null ? null : token,
      };
}
