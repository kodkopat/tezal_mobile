// To parse this JSON data, do
//
//     final marketCommentsResultModel = marketCommentsResultModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class MarketCommentsResultModel {
  MarketCommentsResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final dynamic message;
  final List<Comment> data;

  factory MarketCommentsResultModel.fromRawJson(String str) =>
      MarketCommentsResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MarketCommentsResultModel.fromJson(Map<String, dynamic> json) =>
      MarketCommentsResultModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<Comment>.from(json["data"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Comment {
  Comment({
    @required this.id,
    @required this.comment,
    @required this.point,
    @required this.page,
    @required this.total,
  });

  final String id;
  final String comment;
  final int point;
  final int page;
  final int total;

  factory Comment.fromRawJson(String str) => Comment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"] == null ? null : json["id"],
        comment: json["comment"] == null ? null : json["comment"],
        point: json["point"] == null ? null : json["point"],
        page: json["page"] == null ? null : json["page"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "comment": comment == null ? null : comment,
        "point": point == null ? null : point,
        "page": page == null ? null : page,
        "total": total == null ? null : total,
      };
}
