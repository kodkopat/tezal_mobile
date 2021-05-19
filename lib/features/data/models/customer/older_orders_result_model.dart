class OlderOrdersResultModel {
  OlderOrdersResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final Data? data;

  factory OlderOrdersResultModel.fromJson(Map<String, dynamic> json) =>
      OlderOrdersResultModel(
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
    required this.orders,
  });

  final totalCount;
  final List<Order>? orders;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalCount: json["totalCount"],
        orders: json["orders"] == null
            ? null
            : List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "orders": orders == null
            ? null
            : List<dynamic>.from(orders!.map((x) => x.toJson())),
      };
}

class Order {
  Order({
    required this.id,
    required this.orderNumber,
    required this.date,
    required this.marketName,
    required this.status,
    required this.totalPrice,
  });

  final id;
  final orderNumber;
  final date;
  final marketName;
  final status;
  final totalPrice;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        orderNumber: json["orderNumber"],
        date: json["date"],
        marketName: json["marketName"],
        status: json["status"],
        totalPrice: json["totalPrice"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderNumber": orderNumber,
        "date": date,
        "marketName": marketName,
        "status": status,
        "totalPrice": totalPrice,
      };
}
