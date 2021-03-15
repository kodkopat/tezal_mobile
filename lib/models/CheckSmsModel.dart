import 'dart:convert';

CheckSmsModel checkSmsModelFromJson(String str) =>
    CheckSmsModel.fromJson(json.decode(str));

String checkSmsModelToJson(CheckSmsModel data) => json.encode(data.toJson());

class CheckSmsModel {
  CheckSmsModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  dynamic message;
  Data data;

  factory CheckSmsModel.fromJson(Map<String, dynamic> json) => CheckSmsModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.token,
    this.name,
    this.phone,
  });

  String token;
  String name;
  dynamic phone;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        name: json["name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "name": name,
        "phone": phone,
      };
}
