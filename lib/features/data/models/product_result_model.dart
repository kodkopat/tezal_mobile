import 'package:meta/meta.dart';

class ProductResultModel {
  ProductResultModel({
    @required this.id,
    @required this.name,
    @required this.discountedPrice,
    @required this.totalDiscount,
    @required this.originalPrice,
    @required this.liked,
    @required this.discountRate,
    @required this.productUnit,
    @required this.step,
    @required this.amount,
  });

  final id;
  final name;
  final discountedPrice;
  final totalDiscount;
  final originalPrice;
  final liked;
  final discountRate;
  final productUnit;
  final step;
  final amount;

  factory ProductResultModel.fromJson(Map<String, dynamic> json) =>
      ProductResultModel(
        id: json["id"],
        name: json["name"],
        discountedPrice: json["discountedPrice"],
        totalDiscount: json["totalDiscount"],
        originalPrice: json["originalPrice"],
        liked: json["liked"],
        discountRate: json["discountRate"],
        productUnit: json["productUnit"],
        step: json["step"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "discountedPrice": discountedPrice,
        "totalDiscount": totalDiscount,
        "originalPrice": originalPrice,
        "liked": liked,
        "discountRate": discountRate,
        "productUnit": productUnit,
        "step": step,
        "amount": amount,
      };
}
