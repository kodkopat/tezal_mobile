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
  final Data data;

  factory PhotosResultModel.fromRawJson(String str) =>
      PhotosResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PhotosResultModel.fromJson(Map<String, dynamic> json) =>
      PhotosResultModel(
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
    @required this.photos,
  });

  final List<String> photos;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        photos: json["photos"] == null
            ? null
            : List<String>.from(json["photos"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "photos":
            photos == null ? null : List<dynamic>.from(photos.map((x) => x)),
      };
}
