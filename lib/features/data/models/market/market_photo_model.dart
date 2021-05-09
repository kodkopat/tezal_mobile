class MarketPhoto {
  MarketPhoto({
    required this.id,
    required this.photo,
  });

  final id;
  final photo;

  factory MarketPhoto.fromJson(Map<String, dynamic> json) => MarketPhoto(
        id: json["id"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "photo": photo,
      };
}
