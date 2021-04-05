// To parse this JSON data, do
//
//     final searchResultModel = searchResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

import 'product_result_model.dart';

class SearchResultModel {
  SearchResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final dynamic message;
  final Data data;

  factory SearchResultModel.fromRawJson(String str) =>
      SearchResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchResultModel.fromJson(Map<String, dynamic> json) =>
      SearchResultModel(
        success: json["success"] == null ? null : json["success"],
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
    @required this.markets,
  });

  final List<Market> markets;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        markets: json["markets"] == null
            ? null
            : List<Market>.from(json["markets"].map((x) => Market.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "markets": markets == null
            ? null
            : List<dynamic>.from(markets.map((x) => x.toJson())),
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

  final String name;
  final String address;
  final String id;
  final int openAt;
  final int clouseAt;
  final String situation;
  final int deliveryCost;
  final double distance;
  final List<ProductResultModel> products;

  factory Market.fromRawJson(String str) => Market.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Market.fromJson(Map<String, dynamic> json) => Market(
        name: json["name"] == null ? null : json["name"],
        address: json["address"] == null ? null : json["address"],
        id: json["id"] == null ? null : json["id"],
        openAt: json["openAt"] == null ? null : json["openAt"],
        clouseAt: json["clouseAt"] == null ? null : json["clouseAt"],
        situation: json["situation"] == null ? null : json["situation"],
        deliveryCost:
            json["deliveryCost"] == null ? null : json["deliveryCost"],
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
        products: json["products"] == null
            ? null
            : List<ProductResultModel>.from(
                json["products"].map((x) => ProductResultModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "address": address == null ? null : address,
        "id": id == null ? null : id,
        "openAt": openAt == null ? null : openAt,
        "clouseAt": clouseAt == null ? null : clouseAt,
        "situation": situation == null ? null : situation,
        "deliveryCost": deliveryCost == null ? null : deliveryCost,
        "distance": distance == null ? null : distance,
        "products": products == null
            ? null
            : List<dynamic>.from(products.map((x) => x.toJson())),
      };
}
