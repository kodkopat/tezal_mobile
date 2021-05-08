class AddressResultModel {
  AddressResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final data;

  factory AddressResultModel.fromJson(Map<String, dynamic> json) =>
      AddressResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Address.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? null : data!.toJson(),
      };
}

class Address {
  Address({
    required this.id,
    required this.isDefault,
    required this.name,
    required this.address,
    required this.description,
    required this.city,
    required this.province,
  });

  final id;
  final isDefault;
  final name;
  final address;
  final description;
  final city;
  final province;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        isDefault: json["isDefault"],
        name: json["name"],
        address: json["address"],
        description: json["description"],
        city: json["city"],
        province: json["province"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "isDefault": isDefault,
        "name": name,
        "address": address,
        "description": description,
        "city": city,
        "province": province,
      };
}
