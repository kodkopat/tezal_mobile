class OrderDetailResultModel {
  OrderDetailResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final Data? data;

  factory OrderDetailResultModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.date,
    required this.deliveryCost,
    required this.marketName,
    required this.paymentType,
    required this.status,
    required this.totalDiscount,
    required this.totalPrice,
    required this.items,
  });

  final id;
  final date;
  final deliveryCost;
  final marketName;
  final paymentType;
  final status;
  final totalDiscount;
  final totalPrice;
  final items;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        date: json["date"],
        deliveryCost: json["deliveryCost"],
        marketName: json["marketName"],
        paymentType: json["paymentType"],
        status: json["status"],
        totalDiscount: json["totalDiscount"],
        totalPrice: json["totalPrice"],
        items: json["items"] == null
            ? null
            : List<OrderItem>.from(
                json["items"].map(
                  (x) => OrderItem.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "deliveryCost": deliveryCost,
        "marketName": marketName,
        "paymentType": paymentType,
        "status": status,
        "totalDiscount": totalDiscount,
        "totalPrice": totalPrice,
        "items": items == null
            ? null
            : List<dynamic>.from(
                items.map(
                  (x) => x.toJson(),
                ),
              ),
      };
}

class OrderItem {
  OrderItem({
    required this.id,
    required this.amount,
    required this.productName,
    required this.originalPrice,
    required this.discountedPrice,
    required this.totalDiscount,
    required this.totalPrice,
    required this.payablePrice,
    required this.totalDiscountedPrice,
    required this.step,
    required this.productUnit,
  });

  final id;
  final amount;
  final productName;
  final originalPrice;
  final discountedPrice;
  final totalDiscount;
  final totalPrice;
  final payablePrice;
  final totalDiscountedPrice;
  final step;
  final productUnit;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        amount: json["amount"],
        productName: json["productName"],
        originalPrice: json["originalPrice"],
        discountedPrice: json["discountedPrice"],
        totalDiscount: json["totalDiscount"],
        totalPrice: json["totalPrice"],
        payablePrice: json["payablePrice"],
        totalDiscountedPrice: json["totalDiscountedPrice"],
        step: json["step"],
        productUnit: json["productUnit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "productName": productName,
        "originalPrice": originalPrice,
        "discountedPrice": discountedPrice,
        "totalDiscount": totalDiscount,
        "totalPrice": totalPrice,
        "payablePrice": payablePrice,
        "totalDiscountedPrice": totalDiscountedPrice,
        "step": step,
        "productUnit": productUnit,
      };
}
