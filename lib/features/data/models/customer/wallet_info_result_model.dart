import 'package:meta/meta.dart';

class WalletInfoResultModel {
  WalletInfoResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final success;
  final message;
  final data;

  factory WalletInfoResultModel.fromJson(Map<String, dynamic> json) =>
      WalletInfoResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    @required this.balance,
    @required this.lastActionDate,
  });

  final balance;
  final lastActionDate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        balance: json["balance"],
        lastActionDate: json["lastActionDate"],
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
        "lastActionDate": lastActionDate,
      };
}
