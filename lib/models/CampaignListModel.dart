// To parse this JSON data, do
//
//     final campaignListModel = campaignListModelFromJson(jsonString);

import 'dart:convert';

CampaignListModel campaignListModelFromJson(String str) =>
    CampaignListModel.fromJson(json.decode(str));

String campaignListModelToJson(CampaignListModel data) =>
    json.encode(data.toJson());

class CampaignListModel {
  CampaignListModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  dynamic message;
  List<Data> data;

  factory CampaignListModel.fromJson(Map<String, dynamic> json) =>
      CampaignListModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Data {
  Data({
    this.id,
    this.name,
    this.photo,
  });

  String id;
  String name;
  String photo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        photo: json["photo"] == null ? null : json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "photo": photo == null ? null : photo,
      };
}
