// To parse this JSON data, do
//
//     final addressesResultModel = addressesResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class AddressesResultModel {
  AddressesResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final dynamic message;
  final List<Address> data;

  factory AddressesResultModel.fromRawJson(String str) =>
      AddressesResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddressesResultModel.fromJson(Map<String, dynamic> json) =>
      AddressesResultModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<Address>.from(json["data"].map((x) => Address.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Address {
  Address({
    @required this.id,
    @required this.isDefault,
    @required this.name,
    @required this.address,
  });

  final String id;
  final bool isDefault;
  final String name;
  final String address;

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"] == null ? null : json["id"],
        isDefault: json["isDefault"] == null ? null : json["isDefault"],
        name: json["name"] == null ? null : json["name"],
        address: json["address"] == null ? null : json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "isDefault": isDefault == null ? null : isDefault,
        "name": name == null ? null : name,
        "address": address == null ? null : address,
      };
}
