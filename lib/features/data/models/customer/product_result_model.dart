class ProductResultModel {
  ProductResultModel({
    required this.id,
    required this.mainCategoryId,
    required this.subCategoryId,
    required this.mainCategoryName,
    required this.subCategoryName,
    required this.name,
    required this.originalPrice,
    required this.discountedPrice,
    required this.totalPrice,
    required this.liked,
    required this.discountRate,
    required this.productUnit,
    required this.step,
    required this.rate,
    required this.amount,
    required this.onSale,
    required this.photo,
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
