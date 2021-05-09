import 'market_photo_model.dart';

class MarketPhotoResultModel {
  MarketPhotoResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final MarketPhoto? data;

  factory MarketPhotoResultModel.fromJson(Map<String, dynamic> json) =>
      MarketPhotoResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : MarketPhoto.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? null : data!.toJson(),
      };
}
