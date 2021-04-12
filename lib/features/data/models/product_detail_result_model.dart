import 'package:meta/meta.dart';

class ProductDetailResultModel {
  ProductDetailResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final success;
  final message;
  final data;

  factory ProductDetailResultModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailResultModel(
        success: json["success"],
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
    @required this.subCategoryName,
    @required this.mainCategoryName,
    @required this.subCategoryId,
    @required this.mainCategoryId,
    @required this.marketName,
    @required this.marketAddress,
    @required this.basketCount,
    @required this.liked,
    @required this.description,
    @required this.id,
    @required this.name,
    @required this.originalPrice,
    @required this.discountedPrice,
    @required this.totalDiscount,
    @required this.discountRate,
    @required this.productUnit,
    @required this.step,
    @required this.amount,
  });

  final subCategoryName;
  final mainCategoryName;
  final subCategoryId;
  final mainCategoryId;
  final marketName;
  final marketAddress;
  final basketCount;
  final liked;
  final description;
  final id;
  final name;
  final originalPrice;
  final discountedPrice;
  final totalDiscount;
  final discountRate;
  final productUnit;
  final step;
  final amount;
  factory Data.fromJson(Map<String, dynamic> json) => Data(
        subCategoryName: json["subCategoryName"],
        mainCategoryName: json["mainCategoryName"],
        subCategoryId: json["subCategoryId"],
        mainCategoryId: json["mainCategoryId"],
        marketName: json["marketName"],
        marketAddress: json["marketAddress"],
        basketCount: json["basketCount"],
        liked: json["liked"],
        description: json["description"],
        id: json["id"],
        name: json["name"],
        originalPrice: json["originalPrice"],
        discountedPrice: json["discountedPrice"],
        totalDiscount: json["totalDiscount"],
        discountRate: json["discountRate"],
        productUnit: json["productUnit"],
        step: json["step"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "subCategoryName": subCategoryName,
        "mainCategoryName": mainCategoryName,
        "subCategoryId": subCategoryId,
        "mainCategoryId": mainCategoryId,
        "marketName": marketName,
        "marketAddress": marketAddress,
        "basketCount": basketCount,
        "liked": liked,
        "description": description,
        "id": id,
        "name": name,
        "originalPrice": originalPrice,
        "discountedPrice": discountedPrice,
        "totalDiscount": totalDiscount,
        "discountRate": discountRate,
        "productUnit": productUnit,
        "step": step,
        "amount": amount,
      };
}
