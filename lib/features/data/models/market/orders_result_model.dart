import 'package:meta/meta.dart';

class OrdersResultModel {
  OrdersResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final success;
  final message;
  final List<MarketOrder>? data;

  factory OrdersResultModel.fromJson(Map<String, dynamic> json) =>
      OrdersResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<MarketOrder>.from(
                json["data"].map((x) => MarketOrder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MarketOrder {
  MarketOrder({
    @required this.deliveryTime,
    @required this.paymentType,
    @required this.orderStatus,
    @required this.address,
    @required this.totalPrice,
    @required this.totalDiscount,
    @required this.customerName,
    @required this.customerPhone,
    @required this.deliveryCost,
    @required this.items,
  });

  final deliveryTime;
  final paymentType;
  final orderStatus;
  final address;
  final totalPrice;
  final totalDiscount;
  final customerName;
  final customerPhone;
  final deliveryCost;
  final List<MarketOrderItem>? items;

  factory MarketOrder.fromJson(Map<String, dynamic> json) => MarketOrder(
        deliveryTime: json["deliveryTime"],
        paymentType: json["paymentType"],
        orderStatus: json["orderStatus"],
        address: json["address"],
        totalPrice: json["totalPrice"],
        totalDiscount: json["totalDiscount"],
        customerName: json["customerName"],
        customerPhone: json["customerPhone"],
        deliveryCost: json["deliveryCost"],
        items: json["items"] == null
            ? null
            : List<MarketOrderItem>.from(
                json["items"].map((x) => MarketOrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "deliveryTime": deliveryTime,
        "paymentType": paymentType,
        "orderStatus": orderStatus,
        "address": address,
        "totalPrice": totalPrice,
        "totalDiscount": totalDiscount,
        "customerName": customerName,
        "customerPhone": customerPhone,
        "deliveryCost": deliveryCost,
        "items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class MarketOrderItem {
  MarketOrderItem({
    @required this.amount,
    @required this.originalPrice,
    @required this.discountedPrice,
    @required this.totalPrice,
    @required this.totalDiscount,
    @required this.productName,
    @required this.photoId,
  });

  final amount;
  final originalPrice;
  final discountedPrice;
  final totalPrice;
  final totalDiscount;
  final productName;
  final photoId;

  factory MarketOrderItem.fromJson(Map<String, dynamic> json) =>
      MarketOrderItem(
        amount: json["amount"],
        originalPrice: json["originalPrice"],
        discountedPrice: json["discountedPrice"],
        totalPrice: json["totalPrice"],
        totalDiscount: json["totalDiscount"],
        productName: json["productName"],
        photoId: json["photoId"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "originalPrice": originalPrice,
        "discountedPrice": discountedPrice,
        "totalPrice": totalPrice,
        "totalDiscount": totalDiscount,
        "productName": productName,
        "photoId": photoId,
      };
}
