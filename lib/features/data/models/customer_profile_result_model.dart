// To parse this JSON data, do
//
//     final customerProfileResultModel = customerProfileResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class CustomerProfileResultModel {
  CustomerProfileResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final dynamic message;
  final Data data;

  factory CustomerProfileResultModel.fromRawJson(String str) =>
      CustomerProfileResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerProfileResultModel.fromJson(Map<String, dynamic> json) =>
      CustomerProfileResultModel(
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
    @required this.id,
    @required this.name,
    @required this.phone,
    @required this.email,
  });

  final String id;
  final String name;
  final String phone;
  final dynamic email;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        phone: json["phone"] == null ? null : json["phone"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "phone": phone == null ? null : phone,
        "email": email,
      };
}
