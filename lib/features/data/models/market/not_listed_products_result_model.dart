import 'product_result_model.dart';

class NotListedProductsResultModel {
  NotListedProductsResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final List<ProductResultModel>? data;

  factory NotListedProductsResultModel.fromJson(Map<String, dynamic> json) =>
      NotListedProductsResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<ProductResultModel>.from(
                json["data"].map((x) => ProductResultModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
