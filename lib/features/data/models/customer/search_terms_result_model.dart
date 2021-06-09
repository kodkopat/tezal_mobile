class SearchTermsResultModel {
  SearchTermsResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final List<String>? data;

  factory SearchTermsResultModel.fromJson(Map<String, dynamic> json) =>
      SearchTermsResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<String>.from(json["data"].map((x) => "$x")),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x)),
      };
}
