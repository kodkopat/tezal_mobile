import 'package:meta/meta.dart';

class BasketResultModel {
  BasketResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final success;
  final message;
  final data;

  factory BasketResultModel.fromJson(Map<String, dynamic> json) =>
      BasketResultModel(
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
    @required this.marketId,
    @required this.marketName,
    @required this.totalPrice,
    @required this.totalDiscountedPrice,
    @required this.totalDiscount,
    @required this.deliveryCost,
    @required this.payable,
    @required this.note,
    @required this.items,
  });

  final marketId;
  final marketName;
  final totalPrice;
  final totalDiscountedPrice;
  final totalDiscount;
  final deliveryCost;
  final payable;
  final note;
  final items;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        marketId: json["marketId"],
        marketName: json["marketName"],
        totalPrice: json["totalPrice"],
        totalDiscountedPrice: json["totalDiscountedPrice"],
        totalDiscount: json["totalDiscount"],
        deliveryCost: json["deliveryCost"],
        payable: json["payable"],
        note: json["note"],
        items: json["items"] == null
            ? null
            : List<BasketItem>.from(
                json["items"].map(
                  (x) => BasketItem.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "marketId": marketId,
        "marketName": marketName,
        "totalPrice": totalPrice,
        "totalDiscountedPrice": totalDiscountedPrice,
        "totalDiscount": totalDiscount,
        "deliveryCost": deliveryCost,
        "payable": payable,
        "note": note,
        "items": items == null
            ? null
            : List<dynamic>.from(
                items.map(
                  (x) => x.toJson(),
                ),
              ),
      };
}

class BasketItem {
  BasketItem({
    @required this.id,
    @required this.productName,
    @required this.originalPrice,
    @required this.discountedPrice,
    @required this.totalDiscountedPrice,
    @required this.totalDiscount,
    @required this.totalPrice,
    @required this.payablePrice,
    @required this.productUnit,
    @required this.step,
    @required this.amount,
  });

  final id;
  final productName;
  final originalPrice;
  final discountedPrice;
  final totalDiscountedPrice;
  final totalDiscount;
  final totalPrice;
  final payablePrice;
  final productUnit;
  final step;
  final amount;

  factory BasketItem.fromJson(Map<String, dynamic> json) => BasketItem(
        id: json["id"],
        productName: json["productName"],
        originalPrice: json["originalPrice"],
        discountedPrice: json["discountedPrice"],
        totalDiscountedPrice: json["totalDiscountedPrice"],
        totalDiscount: json["totalDiscount"],
        totalPrice: json["totalPrice"],
        payablePrice: json["payablePrice"],
        productUnit: json["productUnit"],
        step: json["step"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productName": productName,
        "originalPrice": originalPrice,
        "discountedPrice": discountedPrice,
        "totalDiscountedPrice": totalDiscountedPrice,
        "totalDiscount": totalDiscount,
        "totalPrice": totalPrice,
        "payablePrice": payablePrice,
        "productUnit": productUnit,
        "step": step,
        "amount": amount,
      };
}
