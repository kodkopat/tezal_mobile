class ProductDetailResultModel {
  ProductDetailResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final Data? data;

  factory ProductDetailResultModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.mainCategoryId,
    this.subCategoryId,
    this.mainCategoryName,
    this.subCategoryName,
    this.name,
    this.originalPrice,
    this.discountedPrice,
    this.totalPrice,
    this.liked,
    this.discountRate,
    this.productUnit,
    this.step,
    this.rate,
    this.amount,
    this.onSale,
    this.photo,
  });

  final id;
  final mainCategoryId;
  final subCategoryId;
  final mainCategoryName;
  final subCategoryName;
  final name;
  final originalPrice;
  final discountedPrice;
  final totalPrice;
  final liked;
  final discountRate;
  final productUnit;
  final step;
  final rate;
  final amount;
  final onSale;
  final List<String>? photo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        mainCategoryId: json["mainCategoryId"],
        subCategoryId: json["subCategoryId"],
        mainCategoryName: json["mainCategoryName"],
        subCategoryName: json["subCategoryName"],
        name: json["name"],
        originalPrice: json["originalPrice"],
        discountedPrice: json["discountedPrice"],
        totalPrice: json["totalPrice"],
        liked: json["liked"],
        discountRate: json["discountRate"],
        productUnit: json["productUnit"],
        step: json["step"],
        rate: json["rate"],
        amount: json["amount"],
        onSale: json["onSale"],
        photo: json["photo"] == null
            ? null
            : List<String>.from(json["photo"].map((x) => x)),
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
        "totalPrice": totalPrice,
        "liked": liked,
        "discountRate": discountRate,
        "productUnit": productUnit,
        "step": step,
        "rate": rate,
        "amount": amount,
        "onSale": onSale,
        "photo":
            photo == null ? null : List<dynamic>.from(photo!.map((x) => x)),
      };
}
