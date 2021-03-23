// To parse this JSON data, do
//
//     final photoResultModel = photoResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class PhotoResultModel {
  PhotoResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final dynamic message;
  final Data data;

  factory PhotoResultModel.fromRawJson(String str) =>
      PhotoResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PhotoResultModel.fromJson(Map<String, dynamic> json) =>
      PhotoResultModel(
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
    @required this.photo,
  });

  final String photo;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        photo: json["photo"] == null ? null : json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "photo": photo == null ? null : photo,
      };
}
