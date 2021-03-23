// To parse this JSON data, do
//
//     final photosResultModel = photosResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class PhotosResultModel {
  PhotosResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final dynamic message;
  final List<String> data;

  factory PhotosResultModel.fromRawJson(String str) =>
      PhotosResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PhotosResultModel.fromJson(Map<String, dynamic> json) =>
      PhotosResultModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<String>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x)),
      };
}
