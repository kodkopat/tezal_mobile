import 'package:meta/meta.dart';

class ProductResultModel {
  ProductResultModel({
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

  factory ProductResultModel.fromJson(Map<String, dynamic> json) =>
      ProductResultModel(
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
        discountRate: json["discountRate"],
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
