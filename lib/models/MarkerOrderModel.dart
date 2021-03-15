// To parse this JSON data, do
//
//     final marketOrderModel = marketOrderModelFromJson(jsonString);

import 'dart:convert';

MarketOrderModel marketOrderModelFromJson(String str) =>
    MarketOrderModel.fromJson(json.decode(str));

String marketOrderModelToJson(MarketOrderModel data) =>
    json.encode(data.toJson());

class MarketOrderModel {
  MarketOrderModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  dynamic message;
  List<MarketOrder> data;

  factory MarketOrderModel.fromJson(Map<String, dynamic> json) =>
      MarketOrderModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<MarketOrder>.from(
                json["data"].map((x) => MarketOrder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MarketOrder {
  MarketOrder({
    this.id,
    this.photo,
    this.walletTotal,
    this.orderCount,
    this.orders,
  });

  String id;
  String photo;
  int walletTotal;
  int orderCount;
  List<Order> orders;

  factory MarketOrder.fromJson(Map<String, dynamic> json) => MarketOrder(
        id: json["id"] == null ? null : json["id"],
        photo: json["photo"] == null ? null : json["photo"],
        walletTotal: json["walletTotal"] == null ? null : json["walletTotal"],
        orderCount: json["orderCount"] == null ? null : json["orderCount"],
        orders: json["orders"] == null
            ? null
            : List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "photo": photo == null ? null : photo,
        "walletTotal": walletTotal == null ? null : walletTotal,
        "orderCount": orderCount == null ? null : orderCount,
        "orders": orders == null
            ? null
            : List<dynamic>.from(orders.map((x) => x.toJson())),
      };
}

class Order {
  Order({
    this.id,
    this.customerName,
    this.customerPhone,
    this.deliveryTime,
    this.createTime,
    this.paymentType,
    this.orderStatus,
    this.passingTime,
    this.address,
    this.totalPrice,
  });
  String id;
  String customerName;
  String customerPhone;
  dynamic deliveryTime;
  String createTime;
  String paymentType;
  String orderStatus;
  String passingTime;
  String address;
  int totalPrice;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"] == null ? null : json["id"],
        customerName:
            json["customerName"] == null ? null : json["customerName"],
        customerPhone:
            json["customerPhone"] == null ? null : json["customerPhone"],
        deliveryTime: json["deliveryTime"],
        createTime: json["createTime"] == null ? null : json["createTime"],
        passingTime: json["passingTime"] == null ? null : json["passingTime"],
        paymentType: json["paymentType"] == null ? null : json["paymentType"],
        orderStatus: json["orderStatus"] == null ? null : json["orderStatus"],
        address: json["address"] == null ? null : json["address"],
        totalPrice: json["totalPrice"] == null ? null : json["totalPrice"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "customerName": customerName == null ? null : customerName,
        "customerPhone": customerPhone == null ? null : customerPhone,
        "deliveryTime": deliveryTime,
        "createTime": createTime == null ? null : createTime,
        "passingTime": passingTime == null ? null : passingTime,
        "paymentType": paymentType == null ? null : paymentType,
        "orderStatus": orderStatus == null ? null : orderStatus,
        "address": address == null ? null : address,
        "totalPrice": totalPrice == null ? null : totalPrice,
      };
}
