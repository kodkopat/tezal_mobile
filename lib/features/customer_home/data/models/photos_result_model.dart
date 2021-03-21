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
  final List<Datum> data;

  factory PhotosResultModel.fromRawJson(String str) =>
      PhotosResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PhotosResultModel.fromJson(Map<String, dynamic> json) =>
      PhotosResultModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    @required this.fileContents,
    @required this.contentType,
    @required this.fileDownloadName,
    @required this.lastModified,
    @required this.entityTag,
    @required this.enableRangeProcessing,
  });

  final String fileContents;
  final String contentType;
  final String fileDownloadName;
  final dynamic lastModified;
  final dynamic entityTag;
  final bool enableRangeProcessing;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        fileContents:
            json["fileContents"] == null ? null : json["fileContents"],
        contentType: json["contentType"] == null ? null : json["contentType"],
        fileDownloadName:
            json["fileDownloadName"] == null ? null : json["fileDownloadName"],
        lastModified: json["lastModified"],
        entityTag: json["entityTag"],
        enableRangeProcessing: json["enableRangeProcessing"] == null
            ? null
            : json["enableRangeProcessing"],
      );

  Map<String, dynamic> toJson() => {
        "fileContents": fileContents == null ? null : fileContents,
        "contentType": contentType == null ? null : contentType,
        "fileDownloadName": fileDownloadName == null ? null : fileDownloadName,
        "lastModified": lastModified,
        "entityTag": entityTag,
        "enableRangeProcessing":
            enableRangeProcessing == null ? null : enableRangeProcessing,
      };
}
