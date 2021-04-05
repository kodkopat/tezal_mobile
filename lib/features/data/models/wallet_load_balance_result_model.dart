// To parse this JSON data, do
//
//     final walletLoadBalanceResultModel = walletLoadBalanceResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class WalletLoadBalanceResultModel {
  WalletLoadBalanceResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final dynamic message;
  final Data data;

  factory WalletLoadBalanceResultModel.fromRawJson(String str) =>
      WalletLoadBalanceResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WalletLoadBalanceResultModel.fromJson(Map<String, dynamic> json) =>
      WalletLoadBalanceResultModel(
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
    @required this.transactionId,
  });

  final String transactionId;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        transactionId:
            json["transactionId"] == null ? null : json["transactionId"],
      );

  Map<String, dynamic> toJson() => {
        "transactionId": transactionId == null ? null : transactionId,
      };
}
