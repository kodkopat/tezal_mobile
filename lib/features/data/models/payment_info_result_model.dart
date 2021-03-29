// To parse this JSON data, do
//
//     final paymentInfoResultModel = paymentInfoResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class PaymentInfoResultModel {
  PaymentInfoResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final dynamic message;
  final Data data;

  factory PaymentInfoResultModel.fromRawJson(String str) =>
      PaymentInfoResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentInfoResultModel.fromJson(Map<String, dynamic> json) =>
      PaymentInfoResultModel(
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
    @required this.address,
  });

  final List<Address> address;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        address: json["address"] == null
            ? null
            : List<Address>.from(
                json["address"].map((x) => Address.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "address": address == null
            ? null
            : List<dynamic>.from(address.map((x) => x.toJson())),
      };
}

class Address {
  Address({
    @required this.id,
    @required this.createDate,
    @required this.isSelected,
    @required this.name,
    @required this.city,
    @required this.isDefault,
    @required this.address,
  });

  final String id;
  final DateTime createDate;
  final bool isSelected;
  final String name;
  final String city;
  final bool isDefault;
  final String address;

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"] == null ? null : json["id"],
        createDate: json["createDate"] == null
            ? null
            : DateTime.parse(json["createDate"]),
        isSelected: json["isSelected"] == null ? null : json["isSelected"],
        name: json["name"] == null ? null : json["name"],
        city: json["city"] == null ? null : json["city"],
        isDefault: json["isDefault"] == null ? null : json["isDefault"],
        address: json["address"] == null ? null : json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "createDate": createDate == null ? null : createDate.toIso8601String(),
        "isSelected": isSelected == null ? null : isSelected,
        "name": name == null ? null : name,
        "city": city == null ? null : city,
        "isDefault": isDefault == null ? null : isDefault,
        "address": address == null ? null : address,
      };
}
