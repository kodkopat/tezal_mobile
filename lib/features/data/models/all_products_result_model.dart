import 'package:meta/meta.dart';

class AllProductsResultModel {
  AllProductsResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final success;
  final message;
  final data;

  factory AllProductsResultModel.fromJson(Map<String, dynamic> json) =>
      AllProductsResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    @required this.subCategoryName,
    @required this.mainCategoryName,
    @required this.subCategoryId,
    @required this.mainCategoryId,
    @required this.id,
    @required this.name,
    @required this.discountedPrice,
    @required this.originalPrice,
    @required this.discountRate,
    @required this.amount,
  });

  final subCategoryName;
  final mainCategoryName;
  final subCategoryId;
  final mainCategoryId;
  final id;
  final name;
  final discountedPrice;
  final originalPrice;
  final discountRate;
  final amount;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        subCategoryName: json["subCategoryName"],
        mainCategoryName: json["mainCategoryName"],
        subCategoryId: json["subCategoryId"],
        mainCategoryId: json["mainCategoryId"],
        id: json["id"],
        name: json["name"],
        discountedPrice: json["discountedPrice"],
        originalPrice: json["originalPrice"],
        discountRate: json["discountRate"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "subCategoryName": subCategoryName,
        "mainCategoryName": mainCategoryName,
        "subCategoryId": subCategoryId,
        "mainCategoryId": mainCategoryId,
        "id": id,
        "name": name,
        "discountedPrice": discountedPrice,
        "originalPrice": originalPrice,
        "discountRate": discountRate,
        "amount": amount,
      };
}
