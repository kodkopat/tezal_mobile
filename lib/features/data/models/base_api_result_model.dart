import 'package:meta/meta.dart';

class BaseApiResultModel {
  BaseApiResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final success;
  final message;
  final data;

  factory BaseApiResultModel.fromJson(Map<String, dynamic> json) =>
      BaseApiResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data,
      };
}
