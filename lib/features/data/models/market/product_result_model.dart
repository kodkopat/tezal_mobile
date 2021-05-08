class ProductResultModel {
  ProductResultModel({
    required this.id,
    required this.name,
    required this.createDate,
    required this.description,
    required this.discountedPrice,
    required this.onSale,
    required this.originalPrice,
    required this.productUnit,
    required this.step,
  });

  final id;
  final name;
  final createDate;
  final description;
  final discountedPrice;
  final onSale;
  final originalPrice;
  final productUnit;
  final step;

  factory ProductResultModel.fromJson(Map<String, dynamic> json) =>
      ProductResultModel(
        id: json["id"],
        name: json["name"],
        createDate: json["createDate"],
        description: json["description"],
        discountedPrice: json["discountedPrice"],
        onSale: json["onSale"],
        originalPrice: json["originalPrice"],
        productUnit: json["productUnit"],
        step: json["step"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "createDate": createDate,
        "description": description,
        "discountedPrice": discountedPrice,
        "onSale": onSale,
        "originalPrice": originalPrice,
        "productUnit": productUnit,
        "step": step,
      };
}
