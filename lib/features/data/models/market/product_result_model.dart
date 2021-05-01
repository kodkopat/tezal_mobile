import 'package:meta/meta.dart';

class ProductResultModel {
  ProductResultModel({
    @required this.id,
    @required this.productId,
    @required this.productName,
    @required this.amount,
    @required this.description,
    @required this.discountedPrice,
    @required this.discountRate,
    @required this.onSale,
    @required this.originalPrice,
    @required this.rate,
  });

  final id;
  final productId;
  final productName;
  final amount;
  final description;
  final discountedPrice;
  final discountRate;
  final onSale;
  final originalPrice;
  final rate;

  factory ProductResultModel.fromJson(Map<String, dynamic> json) =>
      ProductResultModel(
        id: json["id"],
        productId: json["productId"],
        productName: json["productName"],
        amount: json["amount"],
        description: json["description"],
        discountedPrice: json["discountedPrice"],
        discountRate: json["discountRate"],
        onSale: json["onSale"],
        originalPrice: json["originalPrice"],
        rate: json["rate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "productName": productName,
        "amount": amount,
        "description": description,
        "discountedPrice": discountedPrice,
        "discountRate": discountRate,
        "onSale": onSale,
        "originalPrice": originalPrice,
        "rate": rate,
      };
}
