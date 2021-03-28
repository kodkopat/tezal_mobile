// To parse this JSON data, do
//
//     final addressResultModel = addressResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class AddressResultModel {
  AddressResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final dynamic message;
  final Address data;

  factory AddressResultModel.fromRawJson(String str) =>
      AddressResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddressResultModel.fromJson(Map<String, dynamic> json) =>
      AddressResultModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Address.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message,
        "data": data == null ? null : data.toJson(),
      };
}

class Address {
  Address({
    @required this.id,
    @required this.isDefault,
    @required this.name,
    @required this.address,
    @required this.description,
    @required this.city,
    @required this.province,
  });

  final String id;
  final bool isDefault;
  final String name;
  final String address;
  final String description;
  final dynamic city;
  final String province;

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"] == null ? null : json["id"],
        isDefault: json["isDefault"] == null ? null : json["isDefault"],
        name: json["name"] == null ? null : json["name"],
        address: json["address"] == null ? null : json["address"],
        description: json["description"] == null ? null : json["description"],
        city: json["city"],
        province: json["province"] == null ? null : json["province"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "isDefault": isDefault == null ? null : isDefault,
        "name": name == null ? null : name,
        "address": address == null ? null : address,
        "description": description == null ? null : description,
        "city": city,
        "province": province == null ? null : province,
      };
}
