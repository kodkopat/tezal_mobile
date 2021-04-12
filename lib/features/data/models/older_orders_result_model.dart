import 'package:meta/meta.dart';

class OlderOrdersResultModel {
  OlderOrdersResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final success;
  final message;
  final data;

  factory OlderOrdersResultModel.fromJson(Map<String, dynamic> json) =>
      OlderOrdersResultModel(
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
    @required this.page,
    @required this.total,
    @required this.orders,
  });

  final page;
  final total;
  final orders;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        page: json["page"],
        total: json["total"],
        orders: json["orders"] == null
            ? null
            : List<Order>.from(
                json["orders"].map(
                  (x) => Order.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "total": total,
        "orders": orders == null
            ? null
            : List<dynamic>.from(
                orders.map(
                  (x) => x.toJson(),
                ),
              ),
      };
}

class Order {
  Order({
    @required this.id,
    @required this.date,
    @required this.marketName,
    @required this.status,
    @required this.totalPrice,
  });

  final id;
  final date;
  final marketName;
  final status;
  final totalPrice;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        date: json["date"],
        marketName: json["marketName"],
        status: json["status"],
        totalPrice: json["totalPrice"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "marketName": marketName,
        "status": status,
        "totalPrice": totalPrice,
      };
}
