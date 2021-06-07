class OrdersResultModel {
  OrdersResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final Data? data;

  factory OrdersResultModel.fromJson(Map<String, dynamic> json) =>
      OrdersResultModel(
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
    required this.totalCount,
    required this.result,
  });

  final totalCount;
  final List<MarketOrder>? result;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalCount: json["totalCount"],
        result: json["result"] == null
            ? null
            : List<MarketOrder>.from(
                json["result"].map((x) => MarketOrder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "result": result == null
            ? null
            : List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class MarketOrder {
  MarketOrder({
    required this.deliveryTime,
    required this.paymentType,
    required this.color,
    required this.orderStatus,
    required this.orderStatusKey,
    required this.address,
    required this.totalPrice,
    required this.totalDiscount,
    required this.customerName,
    required this.customerPhone,
    required this.deliveryCost,
    required this.items,
    required this.orderId,
    required this.orderNumber,
  });

  final deliveryTime;
  final paymentType;
  final color;
  final orderStatus;
  final orderStatusKey;
  final address;
  final totalPrice;
  final totalDiscount;
  final customerName;
  final customerPhone;
  final deliveryCost;
  final orderId;
  final orderNumber;
  final List<MarketOrderItem>? items;

  factory MarketOrder.fromJson(Map<String, dynamic> json) => MarketOrder(
        deliveryTime: json["deliveryTime"],
        paymentType: json["paymentType"],
        color: json["color"],
        orderStatus: json["orderStatus"],
        orderStatusKey: json["orderStatusKey"],
        address: json["address"],
        totalPrice: json["totalPrice"],
        totalDiscount: json["totalDiscount"],
        customerName: json["customerName"],
        customerPhone: json["customerPhone"],
        deliveryCost: json["deliveryCost"],
        orderId: json["orderId"],
        orderNumber: json["orderNumber"],
        items: json["items"] == null
            ? null
            : List<MarketOrderItem>.from(
                json["items"].map((x) => MarketOrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "deliveryTime": deliveryTime,
        "paymentType": paymentType,
        "color": color,
        "orderStatus": orderStatus,
        "orderStatusKey": orderStatusKey,
        "address": address,
        "totalPrice": totalPrice,
        "totalDiscount": totalDiscount,
        "customerName": customerName,
        "customerPhone": customerPhone,
        "deliveryCost": deliveryCost,
        "orderId": orderId,
        "orderNumber": orderNumber,
        "items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class MarketOrderItem {
  MarketOrderItem({
    required this.amount,
    required this.originalPrice,
    required this.discountedPrice,
    required this.totalPrice,
    required this.totalDiscount,
    required this.productName,
    required this.photoId,
  });

  final amount;
  final originalPrice;
  final discountedPrice;
  final totalPrice;
  final totalDiscount;
  final productName;
  final photoId;

  factory MarketOrderItem.fromJson(Map<String, dynamic> json) =>
      MarketOrderItem(
        amount: json["amount"],
        originalPrice: json["originalPrice"],
        discountedPrice: json["discountedPrice"],
        totalPrice: json["totalPrice"],
        totalDiscount: json["totalDiscount"],
        productName: json["productName"],
        photoId: json["photoId"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "originalPrice": originalPrice,
        "discountedPrice": discountedPrice,
        "totalPrice": totalPrice,
        "totalDiscount": totalDiscount,
        "productName": productName,
        "photoId": photoId,
      };
}
