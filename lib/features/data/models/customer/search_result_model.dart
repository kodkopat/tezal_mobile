class SearchResultModel {
  SearchResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final List<SearchMarketResult>? data;

  factory SearchResultModel.fromJson(Map<String, dynamic> json) =>
      SearchResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<SearchMarketResult>.from(
                json["data"].map((x) => SearchMarketResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SearchMarketResult {
  SearchMarketResult({
    required this.name,
    required this.address,
    required this.id,
    required this.openAt,
    required this.clouseAt,
    required this.situation,
    required this.deliveryCost,
    required this.distance,
    required this.photo,
    required this.products,
  });

  final name;
  final address;
  final id;
  final openAt;
  final clouseAt;
  final situation;
  final deliveryCost;
  final distance;
  final List<String>? photo;
  final List<SearchProductResult>? products;

  factory SearchMarketResult.fromJson(Map<String, dynamic> json) =>
      SearchMarketResult(
        name: json["name"],
        address: json["address"],
        id: json["id"],
        openAt: json["openAt"],
        clouseAt: json["clouseAt"],
        situation: json["situation"],
        deliveryCost: json["deliveryCost"],
        distance: json["distance"].toDouble(),
        photo: json["photo"] == null
            ? null
            : List<String>.from(json["photo"].map((x) => x)),
        products: json["products"] == null
            ? null
            : List<SearchProductResult>.from(
                json["products"].map((x) => SearchProductResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "id": id,
        "openAt": openAt,
        "clouseAt": clouseAt,
        "situation": situation,
        "deliveryCost": deliveryCost,
        "distance": distance,
        "photo":
            photo == null ? null : List<dynamic>.from(photo!.map((x) => x)),
        "products": products == null
            ? null
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class SearchProductResult {
  SearchProductResult({
    required this.liked,
    required this.id,
    required this.name,
    required this.originalPrice,
    required this.discountedPrice,
    required this.discountRate,
    required this.productUnit,
    required this.step,
    required this.totalDiscount,
    required this.amount,
    required this.photo,
  });

  final liked;
  final id;
  final name;
  final originalPrice;
  final discountedPrice;
  final discountRate;
  final productUnit;
  final step;
  final totalDiscount;
  final amount;
  final List<String>? photo;

  factory SearchProductResult.fromJson(Map<String, dynamic> json) =>
      SearchProductResult(
        liked: json["liked"],
        id: json["id"],
        name: json["name"],
        originalPrice: json["originalPrice"],
        discountedPrice: json["discountedPrice"],
        discountRate: json["discountRate"].toDouble(),
        productUnit: json["productUnit"],
        step: json["step"],
        totalDiscount: json["totalDiscount"].toDouble(),
        amount: json["amount"],
        photo: json["photo"] == null
            ? null
            : List<String>.from(json["photo"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "liked": liked,
        "id": id,
        "name": name,
        "originalPrice": originalPrice,
        "discountedPrice": discountedPrice,
        "discountRate": discountRate,
        "productUnit": productUnit,
        "step": step,
        "totalDiscount": totalDiscount,
        "amount": amount,
        "photo":
            photo == null ? null : List<dynamic>.from(photo!.map((x) => x)),
      };
}
