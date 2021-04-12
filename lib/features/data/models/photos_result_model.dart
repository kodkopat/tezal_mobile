import 'package:meta/meta.dart';

class PhotosResultModel {
  PhotosResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final success;
  final message;
  final data;

  factory PhotosResultModel.fromJson(Map<String, dynamic> json) =>
      PhotosResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    @required this.photos,
  });

  final photos;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        photos: json["photos"] == null
            ? null
            : List<String>.from(json["photos"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "photos":
            photos == null ? null : List<dynamic>.from(photos.map((x) => x)),
      };
}
