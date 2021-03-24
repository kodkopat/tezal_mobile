// To parse this JSON data, do
//
//     final searchTermsResultModel = searchTermsResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class SearchTermsResultModel {
  SearchTermsResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final dynamic message;
  final List<String> data;

  factory SearchTermsResultModel.fromRawJson(String str) =>
      SearchTermsResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchTermsResultModel.fromJson(Map<String, dynamic> json) =>
      SearchTermsResultModel(
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
