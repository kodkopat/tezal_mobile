import 'package:meta/meta.dart';

class MarketProductsResultModel {
  MarketProductsResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final success;
  final message;
  final List<MarketProduct>? data;

  factory MarketProductsResultModel.fromJson(Map<String, dynamic> json) =>
      MarketProductsResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<MarketProduct>.from(
                json["data"].map((x) => MarketProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MarketProduct {
  MarketProduct({
    @required this.productId,
    @required this.productName,
    @required this.productCreateDate,
    @required this.productDescription,
    @required this.productDiscountedPrice,
    @required this.productOnSale,
    @required this.productOriginalPrice,
    @required this.productUnit,
    @required this.productStep,
    @required this.id,
    @required this.amount,
    @required this.description,
    @required this.discountedPrice,
    @required this.discountRate,
    @required this.onSale,
    @required this.originalPrice,
    @required this.rate,
    @required this.totalDiscount,
  });

  final productId;
  final productName;
  final productCreateDate;
  final productDescription;
  final productDiscountedPrice;
  final productOnSale;
  final productOriginalPrice;
  final productUnit;
  final productStep;
  final id;
  final amount;
  final description;
  final discountedPrice;
  final discountRate;
  final onSale;
  final originalPrice;
  final rate;
  final totalDiscount;

  factory MarketProduct.fromJson(Map<String, dynamic> json) => MarketProduct(
        productId: json["productId"],
        productName: json["productName"],
        productCreateDate: json["productCreateDate"],
        productDescription: json["productDescription"],
        productDiscountedPrice: json["productDiscountedPrice"],
        productOnSale: json["productOnSale"],
        productOriginalPrice: json["productOriginalPrice"],
        productUnit: json["productUnit"],
        productStep: json["productStep"],
        id: json["id"],
        amount: json["amount"],
        description: json["description"],
        discountedPrice: json["discountedPrice"],
        discountRate: json["discountRate"],
        onSale: json["onSale"],
        originalPrice: json["originalPrice"],
        rate: json["rate"],
        totalDiscount: json["totalDiscount"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "productCreateDate": productCreateDate,
        "productDescription": productDescription,
        "productDiscountedPrice": productDiscountedPrice,
        "productOnSale": productOnSale,
        "productOriginalPrice": productOriginalPrice,
        "productUnit": productUnit,
        "productStep": productStep,
        "id": id,
        "amount": amount,
        "description": description,
        "discountedPrice": discountedPrice,
        "discountRate": discountRate,
        "onSale": onSale,
        "originalPrice": originalPrice,
        "rate": rate,
        "totalDiscount": totalDiscount,
      };
}
