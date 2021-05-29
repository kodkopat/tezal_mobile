class AddEditCommentRateResultModel {
  AddEditCommentRateResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final Data? data;

  factory AddEditCommentRateResultModel.fromJson(Map<String, dynamic> json) =>
      AddEditCommentRateResultModel(
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
    required this.comment,
    required this.point,
  });

  final id;
  final comment;
  final point;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        comment: json["comment"],
        point: json["point"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "point": point,
      };
}
