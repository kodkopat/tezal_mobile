class CampaignResultModel {
  CampaignResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final data;

  factory CampaignResultModel.fromJson(Map<String, dynamic> json) =>
      CampaignResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<Campaign>.from(
                json["data"].map((x) => Campaign.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Campaign {
  Campaign({
    required this.id,
    required this.name,
  });

  final id;
  final name;

  factory Campaign.fromJson(Map<String, dynamic> json) => Campaign(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
