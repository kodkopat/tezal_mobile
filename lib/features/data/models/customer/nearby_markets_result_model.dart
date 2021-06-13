class NearByMarketsResultModel {
  NearByMarketsResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final List<MarketCategory>? data;

  factory NearByMarketsResultModel.fromJson(Map<String, dynamic> json) =>
      NearByMarketsResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<MarketCategory>.from(
                json["data"].map((x) => MarketCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MarketCategory {
  MarketCategory({
    required this.id,
    required this.name,
    required this.markets,
  });

  final id;
  final name;
  final List<Market>? markets;

  factory MarketCategory.fromJson(Map<String, dynamic> json) => MarketCategory(
        id: json["id"],
        name: json["name"],
        markets: json["markets"] == null
            ? null
            : List<Market>.from(json["markets"].map((x) => Market.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "markets": markets == null
            ? null
            : List<dynamic>.from(markets!.map((x) => x.toJson())),
      };
}

class Market {
  Market({
    required this.id,
    required this.address,
    required this.owner,
    required this.location,
    required this.name,
    required this.phone,
    required this.score,
    required this.openAt,
    required this.clouseAt,
    required this.situation,
    required this.deliveryCost,
    required this.distance,
    required this.isLiked,
    required this.photo,
  });

  final id;
  final address;
  final owner;
  final location;
  final name;
  final phone;
  final score;
  final openAt;
  final clouseAt;
  final situation;
  final deliveryCost;
  final distance;
  final isLiked;
  final List<String>? photo;

  factory Market.fromJson(Map<String, dynamic> json) => Market(
        id: json["id"],
        address: json["address"],
        owner: json["owner"],
        location: json["location"],
        name: json["name"],
        phone: json["phone"],
        score: json["score"],
        openAt: json["openAt"],
        clouseAt: json["clouseAt"],
        situation: json["situation"],
        deliveryCost: json["deliveryCost"],
        distance: json["distance"],
        isLiked: json["isLiked"],
        photo: json["photo"] == null
            ? null
            : List<String>.from(json["photo"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "owner": owner,
        "location": location,
        "name": name,
        "phone": phone,
        "score": score,
        "openAt": openAt,
        "clouseAt": clouseAt,
        "situation": situation,
        "deliveryCost": deliveryCost,
        "distance": distance,
        "isLiked": isLiked,
        "photo":
            photo == null ? null : List<dynamic>.from(photo!.map((x) => x)),
      };
}
