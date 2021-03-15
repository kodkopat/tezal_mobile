// To parse this JSON data, do
//
//     final nearByMarketsModel = nearByMarketsModelFromJson(jsonString);

import 'dart:convert';

NearByMarketsModel nearByMarketsModelFromJson(String str) =>
    NearByMarketsModel.fromJson(json.decode(str));

String nearByMarketsModelToJson(NearByMarketsModel data) =>
    json.encode(data.toJson());

class NearByMarketsModel {
  NearByMarketsModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  dynamic message;
  Data data;

  factory NearByMarketsModel.fromJson(Map<String, dynamic> json) =>
      NearByMarketsModel(
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
    this.basketCount,
    this.markets,
  });

  int basketCount;
  List<Market> markets;

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
    this.id,
    this.name,
    this.phone,
    this.address,
    this.location,
    this.score,
    this.distance,
    this.deliveryCost,
    this.basketCount,
  });

  String id;
  String name;
  dynamic phone;
  String address;
  String location;
  int score;
  double distance;
  int deliveryCost;
  int basketCount;

  factory Market.fromJson(Map<String, dynamic> json) => Market(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        phone: json["phone"],
        address: json["address"] == null ? null : json["address"],
        location: json["location"] == null ? null : json["location"],
        score: json["score"] == null ? null : json["score"],
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
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
