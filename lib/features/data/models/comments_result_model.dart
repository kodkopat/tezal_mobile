// To parse this JSON data, do
//
//     final commentsResultModel = commentsResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class CommentsResultModel {
  CommentsResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final dynamic message;
  final Data data;

  factory CommentsResultModel.fromRawJson(String str) =>
      CommentsResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentsResultModel.fromJson(Map<String, dynamic> json) =>
      CommentsResultModel(
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
    @required this.page,
    @required this.total,
    @required this.comments,
  });

  final int page;
  final int total;
  final List<Comment> comments;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        page: json["page"] == null ? null : json["page"],
        total: json["total"] == null ? null : json["total"],
        comments: json["comments"] == null
            ? null
            : List<Comment>.from(
                json["comments"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page == null ? null : page,
        "total": total == null ? null : total,
        "comments": comments == null
            ? null
            : List<dynamic>.from(comments.map((x) => x.toJson())),
      };
}

class Comment {
  Comment({
    @required this.id,
    @required this.comment,
    @required this.point,
    @required this.customerName,
    @required this.customerPhoto,
    @required this.date,
  });

  final String id;
  final String comment;
  final int point;
  final String customerName;
  final dynamic customerPhoto;
  final DateTime date;

  factory Comment.fromRawJson(String str) => Comment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"] == null ? null : json["id"],
        comment: json["comment"] == null ? null : json["comment"],
        point: json["point"] == null ? null : json["point"],
        customerName:
            json["customerName"] == null ? null : json["customerName"],
        customerPhoto: json["customerPhoto"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "comment": comment == null ? null : comment,
        "point": point == null ? null : point,
        "customerName": customerName == null ? null : customerName,
        "customerPhoto": customerPhoto,
        "date": date == null ? null : date.toIso8601String(),
      };
}
