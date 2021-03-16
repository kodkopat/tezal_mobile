// To parse this JSON data, do
//
//     final orderDetailModel = orderDetailModelFromJson(jsonString);

import 'dart:convert';

OrderDetailModel orderDetailModelFromJson(String str) =>
    OrderDetailModel.fromJson(json.decode(str));

String orderDetailModelToJson(OrderDetailModel data) =>
    json.encode(data.toJson());

class OrderDetailModel {
  OrderDetailModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  dynamic message;
  List<OrderDetail> data;

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<OrderDetail>.from(
                json["data"].map((x) => OrderDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class OrderDetail {
  OrderDetail({
    this.amount,
    this.originalPrice,
    this.discountedPrice,
    this.totalPrice,
    this.totalDiscount,
    this.productName,
    this.photoId,
  });

  int amount;
  int originalPrice;
  int discountedPrice;
  int totalPrice;
  int totalDiscount;
  String productName;
  String photoId;

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        amount: json["amount"] == null ? null : json["amount"],
        originalPrice:
            json["originalPrice"] == null ? null : json["originalPrice"],
        discountedPrice:
            json["discountedPrice"] == null ? null : json["discountedPrice"],
        totalPrice: json["totalPrice"] == null ? null : json["totalPrice"],
        totalDiscount:
            json["totalDiscount"] == null ? null : json["totalDiscount"],
        productName: json["productName"] == null ? null : json["productName"],
        photoId: json["photoId"] == null ? null : json["photoId"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount == null ? null : amount,
        "originalPrice": originalPrice == null ? null : originalPrice,
        "discountedPrice": discountedPrice == null ? 0 : discountedPrice,
        "totalPrice": totalPrice == null ? null : totalPrice,
        "totalDiscount": totalDiscount == null ? null : totalDiscount,
        "productName": productName == null ? null : productName,
        "productPhoto": photoId == null ? null : photoId,
      };
}
