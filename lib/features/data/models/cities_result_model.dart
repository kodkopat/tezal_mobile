// To parse this JSON data, do
//
//     final citiesResultModel = citiesResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class CitiesResultModel {
  CitiesResultModel({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  final bool success;
  final dynamic message;
  final List<City> data;

  factory CitiesResultModel.fromRawJson(String str) =>
      CitiesResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CitiesResultModel.fromJson(Map<String, dynamic> json) =>
      CitiesResultModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<City>.from(json["data"].map((x) => City.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class City {
  City({
    @required this.id,
    @required this.name,
  });

  final String id;
  final String name;

  factory City.fromRawJson(String str) => City.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}
