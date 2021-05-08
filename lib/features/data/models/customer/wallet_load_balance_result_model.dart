class WalletLoadBalanceResultModel {
  WalletLoadBalanceResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final data;

  factory WalletLoadBalanceResultModel.fromJson(Map<String, dynamic> json) =>
      WalletLoadBalanceResultModel(
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
    required this.transactionId,
  });

  final transactionId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        transactionId: json["transactionId"],
      );

  Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
      };
}
