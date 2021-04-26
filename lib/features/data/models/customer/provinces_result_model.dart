import 'package:meta/meta.dart';

class ProvincesResultModel {
  ProvincesResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final success;
  final message;
  final data;

  factory ProvincesResultModel.fromJson(Map<String, dynamic> json) =>
      ProvincesResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<Province>.from(
                json["data"].map(
                  (x) => Province.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(
                data.map(
                  (x) => x.toJson(),
                ),
              ),
      };
}

class Province {
  Province({
    @required this.id,
    @required this.name,
  });

  final id;
  final name;

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
