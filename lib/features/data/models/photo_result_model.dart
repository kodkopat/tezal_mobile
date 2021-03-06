import 'photo_model.dart';

class PhotoResultModel {
  PhotoResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final PhotoModel? data;

  factory PhotoResultModel.fromJson(Map<String, dynamic> json) =>
      PhotoResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : PhotoModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? null : data!.toJson(),
      };
}
