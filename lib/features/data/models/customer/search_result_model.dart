import 'package:meta/meta.dart';

import 'product_result_model.dart';

class SearchResultModel {
  SearchResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final success;
  final message;
  final data;

  factory SearchResultModel.fromJson(Map<String, dynamic> json) =>
      SearchResultModel(
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
    @required this.markets,
  });

  final markets;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        markets: json["markets"] == null
            ? null
            : List<Market>.from(
                json["markets"].map(
                  (x) => Market.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "markets": markets == null
            ? null
            : List<dynamic>.from(
                markets.map(
                  (x) => x.toJson(),
                ),
              ),
      };
}

class Market {
  Market({
    @required this.name,
    @required this.address,
    @required this.id,
    @required this.openAt,
    @required this.clouseAt,
    @required this.situation,
    @required this.deliveryCost,
    @required this.distance,
    @required this.products,
  });

  final name;
  final address;
  final id;
  final openAt;
  final clouseAt;
  final situation;
  final deliveryCost;
  final distance;
  final products;

  factory Market.fromJson(Map<String, dynamic> json) => Market(
        name: json["name"],
        address: json["address"],
        id: json["id"],
        openAt: json["openAt"],
        clouseAt: json["clouseAt"],
        situation: json["situation"],
        deliveryCost: json["deliveryCost"],
        distance: json["distance"],
        products: json["products"] == null
            ? null
            : List<ProductResultModel>.from(
                json["products"].map(
                  (x) => ProductResultModel.fromJson(x),
                ),
              ),
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
        "products": products == null
            ? null
            : List<dynamic>.from(
                products.map(
                  (x) => x.toJson(),
                ),
              ),
      };
}
