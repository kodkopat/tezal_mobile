import 'package:meta/meta.dart';

class AgreementResultModel {
  AgreementResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final success;
  final message;
  final data;

  factory AgreementResultModel.fromJson(Map<String, dynamic> json) =>
      AgreementResultModel(
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
  Data({@required this.message});

  final message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
