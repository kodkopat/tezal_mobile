// To parse this JSON data, do
//
//     final olderOrdersResultModel = olderOrdersResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class OlderOrdersResultModel {
    OlderOrdersResultModel({
        @required this.success,
        @required this.message,
        @required this.data,
    });

    final bool success;
    final dynamic message;
    final Data data;

    factory OlderOrdersResultModel.fromRawJson(String str) => OlderOrdersResultModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OlderOrdersResultModel.fromJson(Map<String, dynamic> json) => OlderOrdersResultModel(
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
        @required this.orders,
    });

    final int page;
    final int total;
    final List<Order> orders;

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        page: json["page"] == null ? null : json["page"],
        total: json["total"] == null ? null : json["total"],
        orders: json["orders"] == null ? null : List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "page": page == null ? null : page,
        "total": total == null ? null : total,
        "orders": orders == null ? null : List<dynamic>.from(orders.map((x) => x.toJson())),
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

    final String id;
    final String date;
    final String marketName;
    final String status;
    final int totalPrice;

    factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"] == null ? null : json["id"],
        date: json["date"] == null ? null : json["date"],
        marketName: json["marketName"] == null ? null : json["marketName"],
        status: json["status"] == null ? null : json["status"],
        totalPrice: json["totalPrice"] == null ? null : json["totalPrice"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "date": date == null ? null : date,
        "marketName": marketName == null ? null : marketName,
        "status": status == null ? null : status,
        "totalPrice": totalPrice == null ? null : totalPrice,
    };
}
