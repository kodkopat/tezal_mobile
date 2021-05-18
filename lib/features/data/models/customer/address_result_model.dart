import 'address_model.dart';

class AddressResultModel {
  AddressResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final data;

  factory AddressResultModel.fromJson(Map<String, dynamic> json) =>
      AddressResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Address.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? null : data!.toJson(),
      };
}
