class Address {
  Address({
    required this.id,
    required this.isDefault,
    required this.name,
    required this.address,
    required this.description,
    required this.city,
    required this.province,
    required this.latitude,
    required this.longitude,
  });

  final id;
  final isDefault;
  final name;
  final address;
  final description;
  final city;
  final province;
  final latitude;
  final longitude;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        isDefault: json["isDefault"],
        name: json["name"],
        address: json["address"],
        description: json["description"],
        city: json["city"],
        province: json["province"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "isDefault": isDefault,
        "name": name,
        "address": address,
        "description": description,
        "city": city,
        "province": province,
        "latitude": latitude,
        "longitude": longitude,
      };
}
