// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

AddressModel addressModelFromJson(String str) =>
    AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  AddressModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  dynamic message;
  Data data;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
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
    this.isDefault,
    this.name,
    this.address,
    this.description,
    this.city,
    this.province,
  });

  String id;
  bool isDefault;
  String name;
  String address;
  String description;
  String city;
  String province;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        isDefault: json["isDefault"] == null ? null : json["isDefault"],
        name: json["name"] == null ? null : json["name"],
        address: json["address"] == null ? null : json["address"],
        description: json["description"] == null ? null : json["description"],
        city: json["city"] == null ? null : json["city"],
        province: json["province"] == null ? null : json["province"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "isDefault": isDefault == null ? null : isDefault,
        "name": name == null ? null : name,
        "address": address == null ? null : address,
        "description": description == null ? null : description,
        "city": city == null ? null : city,
        "province": province == null ? null : province,
      };
}
