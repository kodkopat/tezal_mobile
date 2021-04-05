// To parse this JSON data, do
//
//     final walletDetailResultModel = walletDetailResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class WalletDetailResultModel {
  WalletDetailResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final dynamic message;
  final Data data;

  factory WalletDetailResultModel.fromRawJson(String str) =>
      WalletDetailResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WalletDetailResultModel.fromJson(Map<String, dynamic> json) =>
      WalletDetailResultModel(
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
    @required this.details,
  });

  final int page;
  final int total;
  final List<Detail> details;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        page: json["page"] == null ? null : json["page"],
        total: json["total"] == null ? null : json["total"],
        details: json["details"] == null
            ? null
            : List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page == null ? null : page,
        "total": total == null ? null : total,
        "details": details == null
            ? null
            : List<dynamic>.from(details.map((x) => x.toJson())),
      };
}

class Detail {
  Detail({
    @required this.amount,
    @required this.date,
    @required this.description,
    @required this.action,
  });

  final int amount;
  final DateTime date;
  final dynamic description;
  final String action;

  factory Detail.fromRawJson(String str) => Detail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        amount: json["amount"] == null ? null : json["amount"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        description: json["description"],
        action: json["action"] == null ? null : json["action"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount == null ? null : amount,
        "date": date == null ? null : date.toIso8601String(),
        "description": description,
        "action": action == null ? null : action,
      };
}
