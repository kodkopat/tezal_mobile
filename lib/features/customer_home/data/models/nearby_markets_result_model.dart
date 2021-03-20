// To parse this JSON data, do
//
//     final nearByMarketsResultModel = nearByMarketsResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class NearByMarketsResultModel {
  NearByMarketsResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final dynamic message;
  final Data data;

  factory NearByMarketsResultModel.fromRawJson(String str) =>
      NearByMarketsResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NearByMarketsResultModel.fromJson(Map<String, dynamic> json) =>
      NearByMarketsResultModel(
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
    @required this.basketCount,
    @required this.markets,
  });

  final int basketCount;
  final List<Market> markets;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        basketCount: json["basketCount"] == null ? null : json["basketCount"],
        markets: json["markets"] == null
            ? null
            : List<Market>.from(json["markets"].map((x) => Market.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "basketCount": basketCount == null ? null : basketCount,
        "markets": markets == null
            ? null
            : List<dynamic>.from(markets.map((x) => x.toJson())),
      };
}

class Market {
  Market({
    @required this.id,
    @required this.name,
    @required this.phone,
    @required this.address,
    @required this.location,
    @required this.score,
    @required this.distance,
    @required this.deliveryCost,
    @required this.basketCount,
  });

  final String id;
  final String name;
  final dynamic phone;
  final String address;
  final String location;
  final dynamic score;
  final dynamic distance;
  final dynamic deliveryCost;
  final dynamic basketCount;

  factory Market.fromRawJson(String str) => Market.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Market.fromJson(Map<String, dynamic> json) => Market(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        phone: json["phone"],
        address: json["address"] == null ? null : json["address"],
        location: json["location"] == null ? null : json["location"],
        score: json["score"] == null ? null : json["score"],
        distance: json["distance"] == null ? null : json["distance"],
        deliveryCost:
            json["deliveryCost"] == null ? null : json["deliveryCost"],
        basketCount: json["basketCount"] == null ? null : json["basketCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "phone": phone,
        "address": address == null ? null : address,
        "location": location == null ? null : location,
        "score": score == null ? null : score,
        "distance": distance == null ? null : distance,
        "deliveryCost": deliveryCost == null ? null : deliveryCost,
        "basketCount": basketCount == null ? null : basketCount,
      };
}
