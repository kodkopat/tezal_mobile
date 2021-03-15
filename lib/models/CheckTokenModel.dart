// To parse this JSON data, do
//
//     final checkTokenModel = checkTokenModelFromJson(jsonString);

import 'dart:convert';

CheckTokenModel checkTokenModelFromJson(String str) =>
    CheckTokenModel.fromJson(json.decode(str));

String checkTokenModelToJson(CheckTokenModel data) =>
    json.encode(data.toJson());

class CheckTokenModel {
  CheckTokenModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  dynamic message;
  Data data;

  factory CheckTokenModel.fromJson(Map<String, dynamic> json) =>
      CheckTokenModel(
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
    this.name,
    this.type,
  });

  String name;
  String type;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "type": type == null ? null : type,
      };
}
