import 'package:meta/meta.dart';

class CustomerProfileResultModel {
  CustomerProfileResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final success;
  final message;
  final Data? data;

  factory CustomerProfileResultModel.fromJson(Map<String, dynamic> json) =>
      CustomerProfileResultModel(
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
    @required this.id,
    @required this.name,
    @required this.phone,
    @required this.email,
  });

  final id;
  final name;
  final phone;
  final email;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
      };
}
