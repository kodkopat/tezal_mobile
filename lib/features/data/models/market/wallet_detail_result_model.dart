import 'package:meta/meta.dart';

class WalletDetailResultModel {
  WalletDetailResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final success;
  final message;
  final Data? data;

  factory WalletDetailResultModel.fromJson(Map<String, dynamic> json) =>
      WalletDetailResultModel(
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
  final List<WalletDetail>? result;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalCount: json["totalCount"],
        result: json["result"] == null
            ? null
            : List<WalletDetail>.from(
                json["result"].map((x) => WalletDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "result": result == null
            ? null
            : List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class WalletDetail {
  WalletDetail({
    @required this.walletId,
    @required this.wallet,
    @required this.walletActionType,
    @required this.amount,
    @required this.balance,
    @required this.description,
    @required this.id,
    @required this.createDate,
    @required this.creatorId,
    @required this.updateDate,
    @required this.uptaterId,
    @required this.deleteDate,
    @required this.deletorId,
    @required this.active,
    @required this.isDeleted,
  });

  final walletId;
  final wallet;
  final walletActionType;
  final amount;
  final balance;
  final description;
  final id;
  final createDate;
  final creatorId;
  final updateDate;
  final uptaterId;
  final deleteDate;
  final deletorId;
  final active;
  final isDeleted;

  factory WalletDetail.fromJson(Map<String, dynamic> json) => WalletDetail(
        walletId: json["walletId"],
        wallet: json["wallet"],
        walletActionType: json["walletActionType"],
        amount: json["amount"],
        balance: json["balance"],
        description: json["description"],
        id: json["id"],
        createDate: json["createDate"],
        creatorId: json["creatorId"],
        updateDate: json["updateDate"],
        uptaterId: json["uptaterId"],
        deleteDate: json["deleteDate"],
        deletorId: json["deletorId"],
        active: json["active"],
        isDeleted: json["isDeleted"],
      );

  Map<String, dynamic> toJson() => {
        "walletId": walletId,
        "wallet": wallet,
        "walletActionType": walletActionType,
        "amount": amount,
        "balance": balance,
        "description": description,
        "id": id,
        "createDate": createDate,
        "creatorId": creatorId,
        "updateDate": updateDate,
        "uptaterId": uptaterId,
        "deleteDate": deleteDate,
        "deletorId": deletorId,
        "active": active,
        "isDeleted": isDeleted,
      };
}
