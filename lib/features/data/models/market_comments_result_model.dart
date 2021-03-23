// To parse this JSON data, do
//
//     final marketCommentsResultModel = marketCommentsResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class MarketCommentsResultModel {
  MarketCommentsResultModel({
    @required this.data,
    @required this.page,
    @required this.count,
  });

  final List<Comment> data;
  final int page;
  final int count;

  factory MarketCommentsResultModel.fromRawJson(String str) =>
      MarketCommentsResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MarketCommentsResultModel.fromJson(Map<String, dynamic> json) =>
      MarketCommentsResultModel(
        data: json["data"] == null
            ? null
            : List<Comment>.from(json["data"].map((x) => Comment.fromJson(x))),
        page: json["page"] == null ? null : json["page"],
        count: json["count"] == null ? null : json["count"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "page": page == null ? null : page,
        "count": count == null ? null : count,
      };
}

class Comment {
  Comment({
    @required this.createDate,
    @required this.comment,
    @required this.point,
    @required this.userUserName,
    @required this.marketName,
    @required this.commentState,
  });

  final DateTime createDate;
  final String comment;
  final int point;
  final String userUserName;
  final String marketName;
  final int commentState;

  factory Comment.fromRawJson(String str) => Comment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        createDate: json["createDate"] == null
            ? null
            : DateTime.parse(json["createDate"]),
        comment: json["comment"] == null ? null : json["comment"],
        point: json["point"] == null ? null : json["point"],
        userUserName:
            json["userUserName"] == null ? null : json["userUserName"],
        marketName: json["marketName"] == null ? null : json["marketName"],
        commentState:
            json["commentState"] == null ? null : json["commentState"],
      );

  Map<String, dynamic> toJson() => {
        "createDate": createDate == null ? null : createDate.toIso8601String(),
        "comment": comment == null ? null : comment,
        "point": point == null ? null : point,
        "userUserName": userUserName == null ? null : userUserName,
        "marketName": marketName == null ? null : marketName,
        "commentState": commentState == null ? null : commentState,
      };
}
