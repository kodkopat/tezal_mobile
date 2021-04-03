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
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
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
        basketCount: json["basketCount"],
        markets:
            List<Market>.from(json["markets"].map((x) => Market.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "basketCount": basketCount,
        "markets": List<dynamic>.from(markets.map((x) => x.toJson())),
      };
}

class Market {
  Market({
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

  factory Market.fromRawJson(String str) => Market.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Market.fromJson(Map<String, dynamic> json) => Market(
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
        distance: json["distance"].toDouble(),
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
      };
}
