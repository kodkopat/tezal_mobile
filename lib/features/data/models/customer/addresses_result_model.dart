import 'address_model.dart';

class AddressesResultModel {
  AddressesResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final data;

  factory AddressesResultModel.fromJson(Map<String, dynamic> json) =>
      AddressesResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<Address>.from(json["data"].map((x) => Address.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
