import 'dart:convert';

class MarketPhotosResultModel {
  MarketPhotosResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final Data? data;

  factory MarketPhotosResultModel.fromJson(Map<String, dynamic> json) =>
      MarketPhotosResultModel(
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
    required this.totalCount,
    required this.result,
  });

  final totalCount;
  final List<MarketPhoto>? result;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalCount: json["totalCount"],
        result: json["result"] == null
            ? null
            : List<MarketPhoto>.from(
                json["result"].map((x) => MarketPhoto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "result": result == null
            ? null
            : List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class MarketPhoto {
  MarketPhoto({
    required this.id,
    required this.photo,
  });

  final id;
  final photo;

  factory MarketPhoto.fromJson(Map<String, dynamic> json) => MarketPhoto(
        id: json["id"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "photo": photo,
      };
}
