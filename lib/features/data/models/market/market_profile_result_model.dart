class MarketProfileResultModel {
  MarketProfileResultModel({
    required this.success,
    required this.message,
    required this.data,
  });
  final success;
  final message;
  final Data? data;

  factory MarketProfileResultModel.fromJson(Map<String, dynamic> json) =>
      MarketProfileResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.phone,
    required this.telephone,
    required this.email,
    required this.address,
  });

  final id;
  final name;
  final phone;
  final telephone;
  final email;
  final address;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        telephone: json["telephone"],
        email: json["email"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "telephone": telephone,
        "email": email,
        "address": address,
      };
}
