class OrderResultModel {
  OrderResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final data;

  factory OrderResultModel.fromJson(Map<String, dynamic> json) =>
      OrderResultModel(
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
    required this.paymentType,
    required this.orderId,
  });

  final paymentType;
  final orderId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        paymentType: json["paymentType"],
        orderId: json["orderId"],
      );

  Map<String, dynamic> toJson() => {
        "paymentType": paymentType,
        "orderId": orderId,
      };
}
