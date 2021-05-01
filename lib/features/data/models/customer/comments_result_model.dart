import 'package:meta/meta.dart';

class CommentsResultModel {
  CommentsResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final success;
  final message;
  final Data? data;

  factory CommentsResultModel.fromJson(Map<String, dynamic> json) =>
      CommentsResultModel(
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
    @required this.page,
    @required this.total,
    @required this.comments,
  });

  final page;
  final total;
  final List<Comment>? comments;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        page: json["page"],
        total: json["total"],
        comments: json["comments"] == null
            ? null
            : List<Comment>.from(
                json["comments"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "total": total,
        "comments": comments == null
            ? null
            : List<dynamic>.from(comments!.map((x) => x.toJson())),
      };
}

class Comment {
  Comment({
    @required this.id,
    @required this.comment,
    @required this.rate,
    @required this.customerName,
    @required this.customerPhoto,
    @required this.date,
  });

  final id;
  final comment;
  final rate;
  final customerName;
  final customerPhoto;
  final date;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        comment: json["comment"],
        rate: json["rate"],
        customerName: json["customerName"],
        customerPhoto: json["customerPhoto"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "rate": rate,
        "customerName": customerName,
        "customerPhoto": customerPhoto,
        "date": date,
      };
}
