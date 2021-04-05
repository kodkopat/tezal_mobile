// To parse this JSON data, do
//
//     final walletInfoResultModel = walletInfoResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class WalletInfoResultModel {
  WalletInfoResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final dynamic message;
  final Data data;

  factory WalletInfoResultModel.fromRawJson(String str) =>
      WalletInfoResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WalletInfoResultModel.fromJson(Map<String, dynamic> json) =>
      WalletInfoResultModel(
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
    @required this.balance,
    @required this.lastActionDate,
  });

  final int balance;
  final DateTime lastActionDate;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        balance: json["balance"] == null ? null : json["balance"],
        lastActionDate: json["lastActionDate"] == null
            ? null
            : DateTime.parse(json["lastActionDate"]),
      );

  Map<String, dynamic> toJson() => {
        "balance": balance == null ? null : balance,
        "lastActionDate":
            lastActionDate == null ? null : lastActionDate.toIso8601String(),
      };
}
