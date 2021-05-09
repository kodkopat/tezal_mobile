class MarketCommentsResultModel {
  MarketCommentsResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final Data? data;

  factory MarketCommentsResultModel.fromJson(Map<String, dynamic> json) =>
      MarketCommentsResultModel(
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
  final List<MarketComment>? result;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalCount: json["totalCount"],
        result: json["result"] == null
            ? null
            : List<MarketComment>.from(
                json["result"].map((x) => MarketComment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "result": result == null
            ? null
            : List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class MarketComment {
  MarketComment({
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

  factory MarketComment.fromJson(Map<String, dynamic> json) => MarketComment(
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
