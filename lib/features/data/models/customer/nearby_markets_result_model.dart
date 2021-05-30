class NearByMarketsResultModel {
  NearByMarketsResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final Data? data;

  factory NearByMarketsResultModel.fromJson(Map<String, dynamic> json) =>
      NearByMarketsResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    required this.page,
    required this.total,
    required this.markets,
  });

  final page;
  final total;
  final List<Market>? markets;
  factory Data.fromJson(Map<String, dynamic> json) => Data(
        page: json["page"],
        total: json["total"],
        markets: json["markets"] == null
            ? null
            : List<Market>.from(json["markets"].map((x) => Market.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "total": total,
        "markets": markets == null
            ? null
            : List<dynamic>.from(markets!.map((x) => x.toJson())),
      };
}

class Market {
  Market({
    required this.id,
    required this.address,
    required this.location,
    required this.name,
    required this.phone,
    required this.score,
    required this.openAt,
    required this.clouseAt,
    required this.situation,
    required this.deliveryCost,
    required this.distance,
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
        distance: json["distance"],
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
