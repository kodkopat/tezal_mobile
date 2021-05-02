import 'package:meta/meta.dart';

class WalletBalanceResultModel {
  WalletBalanceResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final success;
  final message;
  final Data? data;

  factory WalletBalanceResultModel.fromJson(Map<String, dynamic> json) =>
      WalletBalanceResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    @required this.balance,
  });

  final balance;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        balance: json["balance"],
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
      };
}
