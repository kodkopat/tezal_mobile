import 'package:meta/meta.dart';

class PaymentInfoResultModel {
  PaymentInfoResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final success;
  final message;
  final data;

  factory PaymentInfoResultModel.fromJson(Map<String, dynamic> json) =>
      PaymentInfoResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    @required this.address,
  });

  final address;

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

  final id;
  final createDate;
  final isSelected;
  final name;
  final city;
  final isDefault;
  final address;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        createDate: json["createDate"],
        isSelected: json["isSelected"],
        name: json["name"],
        city: json["city"],
        isDefault: json["isDefault"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createDate": createDate,
        "isSelected": isSelected,
        "name": name,
        "city": city,
        "isDefault": isDefault,
        "address": address,
      };
}
