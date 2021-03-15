// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
    OrderModel({
        this.success,
        this.message,
        this.data,
    });

    bool success;
    dynamic message;
    List<Order> data;

    factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"],
        data: json["data"] == null ? null : List<Order>.from(json["data"].map((x) => Order.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Order {
    Order({
        this.id,
        this.customerName,
        this.customerPhone,
        this.deliveryTime,
        this.createTime,
        this.passingTime,
        this.paymentType,
        this.orderStatus,
        this.totalPrice,
    });

    String id;
    String customerName;
    String customerPhone;
    dynamic deliveryTime;
    String createTime;
    dynamic passingTime;
    String paymentType;
    String orderStatus;
    int totalPrice;

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"] == null ? null : json["id"],
        customerName: json["customerName"] == null ? null : json["customerName"],
        customerPhone: json["customerPhone"] == null ? null : json["customerPhone"],
        deliveryTime: json["deliveryTime"],
        createTime: json["createTime"] == null ? null : json["createTime"],
        passingTime: json["passingTime"],
        paymentType: json["paymentType"] == null ? null : json["paymentType"],
        orderStatus: json["orderStatus"] == null ? null : json["orderStatus"],
        totalPrice: json["totalPrice"] == null ? null : json["totalPrice"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "customerName": customerName == null ? null : customerName,
        "customerPhone": customerPhone == null ? null : customerPhone,
        "deliveryTime": deliveryTime,
        "createTime": createTime == null ? null : createTime,
        "passingTime": passingTime,
        "paymentType": paymentType == null ? null : paymentType,
        "orderStatus": orderStatus == null ? null : orderStatus,
        "totalPrice": totalPrice == null ? null : totalPrice,
    };
}
