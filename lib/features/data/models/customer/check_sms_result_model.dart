class CheckSmsResultModel {
  CheckSmsResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final data;

  factory CheckSmsResultModel.fromJson(Map<String, dynamic> json) =>
      CheckSmsResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson() == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    required this.token,
    required this.name,
    required this.phone,
  });

  final token;
  final name;
  final phone;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        name: json["name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "name": name,
        "phone": phone,
      };
}
