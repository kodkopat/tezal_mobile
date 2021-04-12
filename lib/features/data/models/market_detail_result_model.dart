import 'package:meta/meta.dart';

import 'product_result_model.dart';

class MarketDetailResultModel {
  MarketDetailResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final success;
  final message;
  final data;

  factory MarketDetailResultModel.fromJson(Map<String, dynamic> json) =>
      MarketDetailResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    @required this.id,
    @required this.address,
    @required this.location,
    @required this.name,
    @required this.phone,
    @required this.score,
    @required this.openAt,
    @required this.clouseAt,
    @required this.situation,
    @required this.deliveryCost,
    @required this.distance,
    @required this.categories,
    @required this.basketCount,
  });

  final id;
  final address;
  final location;
  final name;
  final phone;
  final score;
  final openAt;
  final clouseAt;
  final situation;
  final deliveryCost;
  final distance;
  final categories;
  final basketCount;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        address: json["address"],
        location: json["location"],
        name: json["name"],
        phone: json["phone"],
        score: json["score"],
        openAt: json["openAt"],
        clouseAt: json["clouseAt"],
        situation: json["situation"],
        deliveryCost: json["deliveryCost"],
        distance: json["distance"],
        categories: json["categories"] == null
            ? null
            : List<Category>.from(
                json["categories"].map(
                  (x) => Category.fromJson(x),
                ),
              ),
        basketCount: json["basketCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "location": location,
        "name": name,
        "phone": phone,
        "score": score,
        "openAt": openAt,
        "clouseAt": clouseAt,
        "situation": situation,
        "deliveryCost": deliveryCost,
        "distance": distance,
        "categories": categories == null
            ? null
            : List<dynamic>.from(
                categories.map(
                  (x) => x.toJson(),
                ),
              ),
        "basketCount": basketCount,
      };
}

class Category {
  Category({
    @required this.id,
    @required this.name,
    @required this.products,
  });

  final id;
  final name;
  final products;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        products: json["products"] == null
            ? null
            : List<ProductResultModel>.from(
                json["products"].map(
                  (x) => ProductResultModel.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "products": products == null
            ? null
            : List<dynamic>.from(
                products.map(
                  (x) => x.toJson(),
                ),
              ),
      };
}
