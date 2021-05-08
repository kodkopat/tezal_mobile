class AddressesResultModel {
  AddressesResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final data;

  factory AddressesResultModel.fromJson(Map<String, dynamic> json) =>
      AddressesResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<Address>.from(json["data"].map((x) => Address.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Address {
  Address({
    required this.id,
    required this.isDefault,
    required this.name,
    required this.address,
  });

  final id;
  final isDefault;
  final name;
  final address;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        isDefault: json["isDefault"],
        name: json["name"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "isDefault": isDefault,
        "name": name,
        "address": address,
      };
}
