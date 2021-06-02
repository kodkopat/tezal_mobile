class OrdersResultModel {
  OrdersResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final Data? data;

  factory OrdersResultModel.fromJson(Map<String, dynamic> json) =>
      OrdersResultModel(
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
    required this.totalCount,
    required this.result,
  });

  final totalCount;
  final List<OrderItem>? result;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalCount: json["totalCount"],
        result: json["result"] == null
            ? null
            : List<OrderItem>.from(
                json["result"].map((x) => OrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "result": result == null
            ? null
            : List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class OrderItem {
  OrderItem({
    required this.id,
    required this.orderNumber,
    required this.marketName,
    required this.marketAdress,
    required this.marketLocation,
    required this.customerName,
    required this.customerAdress,
    required this.customerLocation,
    required this.status,
    required this.havePeyment,
    required this.paymentCollected,
  });

  final id;
  final orderNumber;
  final marketName;
  final marketAdress;
  final marketLocation;
  final customerName;
  final customerAdress;
  final customerLocation;
  final status;
  final havePeyment;
  final paymentCollected;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        orderNumber: json["orderNumber"],
        marketName: json["marketName"],
        marketAdress: json["marketAdress"],
        marketLocation: json["marketLocation"],
        customerName: json["customerName"],
        customerAdress: json["customerAdress"],
        customerLocation: json["customerLocation"],
        status: json["status"],
        havePeyment: json["havePeyment"],
        paymentCollected: json["paymentCollected"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderNumber": orderNumber,
        "marketName": marketName,
        "marketAdress": marketAdress,
        "marketLocation": marketLocation,
        "customerName": customerName,
        "customerAdress": customerAdress,
        "customerLocation": customerLocation,
        "status": status,
        "havePeyment": havePeyment,
        "paymentCollected": paymentCollected,
      };
}
