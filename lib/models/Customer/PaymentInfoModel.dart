// To parse this JSON data, do
//
//     final paymentInfoModel = paymentInfoModelFromJson(jsonString);

import 'dart:convert';

PaymentInfoModel paymentInfoModelFromJson(String str) =>
    PaymentInfoModel.fromJson(json.decode(str));

String paymentInfoModelToJson(PaymentInfoModel data) =>
    json.encode(data.toJson());

class PaymentInfoModel {
  PaymentInfoModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  dynamic message;
  Data data;

  factory PaymentInfoModel.fromJson(Map<String, dynamic> json) =>
      PaymentInfoModel(
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
    this.address,
    this.paymentMethods,
  });

  List<Address> address;
  List<PaymentMethod> paymentMethods;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        address: json["Address"] == null
            ? null
            : List<Address>.from(
                json["Address"].map((x) => Address.fromJson(x))),
        paymentMethods: json["paymentMethods"] == null
            ? null
            : List<PaymentMethod>.from(
                json["paymentMethods"].map((x) => PaymentMethod.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Address": Address == null
            ? null
            : List<dynamic>.from(address.map((x) => x.toJson())),
        "paymentMethods": paymentMethods == null
            ? null
            : List<dynamic>.from(paymentMethods.map((x) => x.toJson())),
      };
}

class Address {
  Address({
    this.id,
    this.isSelected,
    this.name,
    this.city,
    this.isDefault,
    this.address,
  });

  String id;
  bool isSelected;
  String name;
  String city;
  bool isDefault;
  String address;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"] == null ? null : json["id"],
        isSelected: json["isSelected"] == null ? null : json["isSelected"],
        name: json["name"] == null ? null : json["name"],
        city: json["city"] == null ? null : json["city"],
        isDefault: json["isDefault"] == null ? null : json["isDefault"],
        address: json["Address"] == null ? null : json["Address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "isSelected": isSelected == null ? null : isSelected,
        "name": name == null ? null : name,
        "city": city == null ? null : city,
        "isDefault": isDefault == null ? null : isDefault,
        "Address": Address == null ? null : Address,
      };
}

class PaymentMethod {
  PaymentMethod({
    this.key,
    this.value,
  });

  String key;
  String value;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        key: json["key"] == null ? null : json["key"],
        value: json["value"] == null ? null : json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "value": value == null ? null : value,
      };
}
