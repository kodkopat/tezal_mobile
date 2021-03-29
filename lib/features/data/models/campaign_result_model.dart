// To parse this JSON data, do
//
//     final campaignResultModel = campaignResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class CampaignResultModel {
  CampaignResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final dynamic message;
  final List<Campaign> data;

  factory CampaignResultModel.fromRawJson(String str) =>
      CampaignResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CampaignResultModel.fromJson(Map<String, dynamic> json) =>
      CampaignResultModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<Campaign>.from(
                json["data"].map((x) => Campaign.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Campaign {
  Campaign({
    @required this.id,
    @required this.name,
  });

  final String id;
  final String name;

  factory Campaign.fromRawJson(String str) =>
      Campaign.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Campaign.fromJson(Map<String, dynamic> json) => Campaign(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}
