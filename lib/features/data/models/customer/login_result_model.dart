class LoginResultModel {
  LoginResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final data;

  factory LoginResultModel.fromJson(Map<String, dynamic> json) =>
      LoginResultModel(
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
    required this.name,
    required this.type,
    required this.token,
  });

  final name;
  final type;
  final token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        type: json["type"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "token": token,
      };
}
