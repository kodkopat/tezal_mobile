// To parse this JSON data, do
//
//     final addressListModel = addressListModelFromJson(jsonString);

import 'dart:convert';

AddressListModel addressListModelFromJson(String str) =>
    AddressListModel.fromJson(json.decode(str));

String addressListModelToJson(AddressListModel data) =>
    json.encode(data.toJson());

class AddressListModel {
  AddressListModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  dynamic message;
  List<Datum> data;

  factory AddressListModel.fromJson(Map<String, dynamic> json) =>
      AddressListModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.isDefault,
    this.name,
    this.address,
  });

  String id;
  bool isDefault;
  String name;
  String address;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
