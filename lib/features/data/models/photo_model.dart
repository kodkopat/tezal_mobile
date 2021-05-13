class PhotoModel {
  PhotoModel({
    required this.id,
    required this.photo,
  });

  final id;
  final photo;

  factory PhotoModel.fromJson(Map<String, dynamic> json) => PhotoModel(
        id: json["id"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "photo": photo,
      };
}
