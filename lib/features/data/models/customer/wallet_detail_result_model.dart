import 'package:meta/meta.dart';

class WalletDetailResultModel {
  WalletDetailResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final success;
  final message;
  final data;

  factory WalletDetailResultModel.fromJson(Map<String, dynamic> json) =>
      WalletDetailResultModel(
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
  Data({
    @required this.page,
    @required this.total,
    @required this.details,
  });

  final page;
  final total;
  final details;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        page: json["page"],
        total: json["total"],
        details: json["details"] == null
            ? null
            : List<Detail>.from(
                json["details"].map(
                  (x) => Detail.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "total": total,
        "details": details == null
            ? null
            : List<dynamic>.from(
                details.map(
                  (x) => x.toJson(),
                ),
              ),
      };
}

class Detail {
  Detail({
    @required this.amount,
    @required this.date,
    @required this.description,
    @required this.action,
  });

  final amount;
  final date;
  final description;
  final action;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        amount: json["amount"],
        date: json["date"],
        description: json["description"],
        action: json["action"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "date": date,
        "description": description,
        "action": action,
      };
}
