import 'photo_model.dart';

class PhotosResultModel {
  PhotosResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final List<PhotoModel>? data;

  factory PhotosResultModel.fromJson(Map<String, dynamic> json) =>
      PhotosResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<PhotoModel>.from(
                json["data"].map((x) => PhotoModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
