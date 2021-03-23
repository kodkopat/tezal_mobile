// To parse this JSON data, do
//
//     final provincesResultModel = provincesResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class ProvincesResultModel {
  ProvincesResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final dynamic message;
  final List<Province> data;

  factory ProvincesResultModel.fromRawJson(String str) =>
      ProvincesResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProvincesResultModel.fromJson(Map<String, dynamic> json) =>
      ProvincesResultModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<Province>.from(
                json["data"].map((x) => Province.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Province {
  Province({
    @required this.id,
    @required this.name,
  });

  final String id;
  final String name;

  factory Province.fromRawJson(String str) =>
      Province.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}
