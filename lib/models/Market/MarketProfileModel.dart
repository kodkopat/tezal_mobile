// To parse this JSON data, do
//
//     final customerProfileModel = customerProfileModelFromJson(jsonString);

import 'dart:convert';

MarketProfileModel customerProfileModelFromJson(String str) =>
    MarketProfileModel.fromJson(json.decode(str));

String customerProfileModelToJson(MarketProfileModel data) =>
    json.encode(data.toJson());

class MarketProfileModel {
  MarketProfileModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  dynamic message;
  Data data;

  factory MarketProfileModel.fromJson(Map<String, dynamic> json) =>
      MarketProfileModel(
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
    this.id,
    this.name,
    this.phone,
    this.email,
  });

  String id;
  String name;
  String phone;
  dynamic email;

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
