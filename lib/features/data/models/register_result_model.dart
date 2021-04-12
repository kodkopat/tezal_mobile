import 'package:meta/meta.dart';

class RegisterResultModel {
  RegisterResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final success;
  final message;
  final data;

  factory RegisterResultModel.fromJson(Map<String, dynamic> json) =>
      RegisterResultModel(
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
    @required this.userId,
  });

  final userId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
      };
}
