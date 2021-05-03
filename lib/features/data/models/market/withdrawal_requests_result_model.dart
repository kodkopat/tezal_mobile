import 'package:meta/meta.dart';

class WithdrawalRequestsResultModel {
  WithdrawalRequestsResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final success;
  final message;
  final Data? data;

  factory WithdrawalRequestsResultModel.fromJson(Map<String, dynamic> json) =>
      WithdrawalRequestsResultModel(
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
    @required this.totalCount,
    @required this.result,
  });

  final totalCount;
  final List<WithdrawalRequest>? result;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalCount: json["totalCount"],
        result: json["result"] == null
            ? null
            : List<WithdrawalRequest>.from(
                json["result"].map((x) => WithdrawalRequest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "result": result == null
            ? null
            : List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class WithdrawalRequest {
  WithdrawalRequest({
    @required this.id,
    @required this.description,
  });

  final id;
  final description;

  factory WithdrawalRequest.fromJson(Map<String, dynamic> json) =>
      WithdrawalRequest(
        id: json["id"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
      };
}
