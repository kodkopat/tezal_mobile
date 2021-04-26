// To parse this JSON data, do
//
//     final basketResultModel = basketResultModelFromJson(jsonString);

import 'package:meta/meta.dart';

class BasketResultModel {
  BasketResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final success;
  final message;
  final Data? data;

  factory BasketResultModel.fromJson(Map<String, dynamic> json) =>
      BasketResultModel(
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
    @required this.marketId,
    @required this.marketName,
    @required this.totalPrice,
    @required this.totalDiscountedPrice,
    @required this.totalDiscount,
    @required this.deliveryCost,
    @required this.payablePrice,
    @required this.note,
    @required this.items,
  });

  final marketId;
  final marketName;
  final totalPrice;
  final totalDiscountedPrice;
  final totalDiscount;
  final deliveryCost;
  final payablePrice;
  final note;
  final List<BasketItem>? items;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        marketId: json["marketId"],
        marketName: json["marketName"],
        totalPrice: json["totalPrice"],
        totalDiscountedPrice: json["totalDiscountedPrice"],
        totalDiscount: json["totalDiscount"],
        deliveryCost: json["deliveryCost"],
        payablePrice: json["payablePrice"],
        note: json["note"],
        items: json["items"] == null
            ? null
            : List<BasketItem>.from(
                json["items"].map((x) => BasketItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "marketId": marketId,
        "marketName": marketName,
        "totalPrice": totalPrice,
        "totalDiscountedPrice": totalDiscountedPrice,
        "totalDiscount": totalDiscount,
        "deliveryCost": deliveryCost,
        "payablePrice": payablePrice,
        "note": note,
        "items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class BasketItem {
  BasketItem({
    @required this.id,
    @required this.mainCategoryId,
    @required this.subCategoryId,
    @required this.mainCategoryName,
    @required this.subCategoryName,
    @required this.name,
    @required this.originalPrice,
    @required this.discountedPrice,
    @required this.totalDiscount,
    @required this.totalDiscountedPrice,
    @required this.totalPrice,
    @required this.payablePrice,
    @required this.liked,
    @required this.discountRate,
    @required this.productUnit,
    @required this.step,
    @required this.rate,
    @required this.amount,
  });

  final id;
  final mainCategoryId;
  final subCategoryId;
  final mainCategoryName;
  final subCategoryName;
  final name;
  final originalPrice;
  final discountedPrice;
  final totalDiscount;
  final totalDiscountedPrice;
  final totalPrice;
  final payablePrice;
  final liked;
  final discountRate;
  final productUnit;
  final step;
  final rate;
  final amount;

  factory BasketItem.fromJson(Map<String, dynamic> json) => BasketItem(
        id: json["id"],
        mainCategoryId: json["mainCategoryId"],
        subCategoryId: json["subCategoryId"],
        mainCategoryName: json["mainCategoryName"],
        subCategoryName: json["subCategoryName"],
        name: json["name"],
        originalPrice: json["originalPrice"],
        discountedPrice: json["discountedPrice"],
        totalDiscount: json["totalDiscount"],
        totalDiscountedPrice: json["totalDiscountedPrice"],
        totalPrice: json["totalPrice"],
        payablePrice: json["payablePrice"],
        liked: json["liked"],
        discountRate: json["discountRate"].toDouble(),
        productUnit: json["productUnit"],
        step: json["step"],
        rate: json["rate"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mainCategoryId": mainCategoryId,
        "subCategoryId": subCategoryId,
        "mainCategoryName": mainCategoryName,
        "subCategoryName": subCategoryName,
        "name": name,
        "originalPrice": originalPrice,
        "discountedPrice": discountedPrice,
        "totalDiscount": totalDiscount,
        "totalDiscountedPrice": totalDiscountedPrice,
        "totalPrice": totalPrice,
        "payablePrice": payablePrice,
        "liked": liked,
        "discountRate": discountRate,
        "productUnit": productUnit,
        "step": step,
        "rate": rate,
        "amount": amount,
      };
}
