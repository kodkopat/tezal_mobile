class ProductCommentsResultModel {
  ProductCommentsResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final Data? data;

  factory ProductCommentsResultModel.fromJson(Map<String, dynamic> json) =>
      ProductCommentsResultModel(
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
  final List<ProductComment>? result;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalCount: json["totalCount"],
        result: json["result"] == null
            ? null
            : List<ProductComment>.from(
                json["result"].map((x) => ProductComment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "result": result == null
            ? null
            : List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class ProductComment {
  ProductComment({
    required this.id,
    required this.comment,
    required this.createDate,
    required this.rate,
    required this.orderId,
    required this.reply,
  });

  final id;
  final comment;
  final createDate;
  final rate;
  final orderId;
  final reply;

  factory ProductComment.fromJson(Map<String, dynamic> json) => ProductComment(
        id: json["id"],
        comment: json["comment"],
        createDate: json["createDate"],
        rate: json["rate"],
        orderId: json["orderId"],
        reply: json["reply"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "createDate": createDate,
        "rate": rate,
        "orderId": orderId,
        "reply": reply,
      };
}
