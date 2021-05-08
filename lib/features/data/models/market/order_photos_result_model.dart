class OrderPhorosResultModel {
  OrderPhorosResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final List<OrderPhoto>? data;

  factory OrderPhorosResultModel.fromJson(Map<String, dynamic> json) =>
      OrderPhorosResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<OrderPhoto>.from(
                json["data"].map((x) => OrderPhoto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class OrderPhoto {
  OrderPhoto({
    required this.marketProductId,
    required this.productId,
    required this.photo,
  });

  final marketProductId;
  final productId;
  final photo;

  factory OrderPhoto.fromJson(Map<String, dynamic> json) => OrderPhoto(
        marketProductId: json["marketProductId"],
        productId: json["productId"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "marketProductId": marketProductId,
        "productId": productId,
        "photo": photo,
      };
}
