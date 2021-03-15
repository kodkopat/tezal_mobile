// To parse this JSON data, do
//
//     final basketDetailModel = basketDetailModelFromJson(jsonString);

import 'dart:convert';

BasketDetailModel basketDetailModelFromJson(String str) =>
    BasketDetailModel.fromJson(json.decode(str));

String basketDetailModelToJson(BasketDetailModel data) =>
    json.encode(data.toJson());

class BasketDetailModel {
  BasketDetailModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  dynamic message;
  Data data;

  factory BasketDetailModel.fromJson(Map<String, dynamic> json) =>
      BasketDetailModel(
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
    this.marketId,
    this.marketName,
    this.totalPrice,
    this.totalDiscountedPrice,
    this.totalDiscount,
    this.deliveryCost,
    this.payable,
    this.note,
    this.items,
  });

  String marketId;
  String marketName;
  int totalPrice;
  int totalDiscountedPrice;
  int totalDiscount;
  int deliveryCost;
  int payable;
  String note;
  List<Item> items;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        marketId: json["marketId"] == null ? null : json["marketId"],
        marketName: json["marketName"] == null ? null : json["marketName"],
        totalPrice: json["totalPrice"] == null ? null : json["totalPrice"],
        totalDiscountedPrice: json["totalDiscountedPrice"] == null
            ? null
            : json["totalDiscountedPrice"],
        totalDiscount:
            json["totalDiscount"] == null ? null : json["totalDiscount"],
        deliveryCost:
            json["deliveryCost"] == null ? null : json["deliveryCost"],
        payable: json["payable"] == null ? null : json["payable"],
        note: json["note"] == null ? null : json["note"],
        items: json["items"] == null
            ? null
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "marketId": marketId == null ? null : marketId,
        "marketName": marketName == null ? null : marketName,
        "totalPrice": totalPrice == null ? null : totalPrice,
        "totalDiscountedPrice":
            totalDiscountedPrice == null ? null : totalDiscountedPrice,
        "totalDiscount": totalDiscount == null ? null : totalDiscount,
        "deliveryCost": deliveryCost == null ? null : deliveryCost,
        "payable": payable == null ? null : payable,
        "note": note == null ? null : note,
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    this.id,
    this.productName,
    this.originalPrice,
    this.discountedPrice,
    this.discount,
    this.totalPrice,
    this.totaldiscountedPrice,
    this.amount,
  });

  String id;
  String productName;
  int originalPrice;
  int discountedPrice;
  int discount;
  int totalPrice;
  int totaldiscountedPrice;
  int amount;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"] == null ? null : json["id"],
        productName: json["productName"] == null ? null : json["productName"],
        originalPrice:
            json["originalPrice"] == null ? null : json["originalPrice"],
        discountedPrice:
            json["discountedPrice"] == null ? null : json["discountedPrice"],
        discount: json["discount"] == null ? null : json["discount"],
        totalPrice: json["totalPrice"] == null ? null : json["totalPrice"],
        totaldiscountedPrice: json["totaldiscountedPrice"] == null
            ? null
            : json["totaldiscountedPrice"],
        amount: json["amount"] == null ? null : json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "productName": productName == null ? null : productName,
        "originalPrice": originalPrice == null ? null : originalPrice,
        "discountedPrice": discountedPrice == null ? null : discountedPrice,
        "discount": discount == null ? null : discount,
        "totalPrice": totalPrice == null ? null : totalPrice,
        "totaldiscountedPrice":
            totaldiscountedPrice == null ? null : totaldiscountedPrice,
        "amount": amount == null ? null : amount,
      };
}
