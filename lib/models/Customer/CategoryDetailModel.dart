// To parse this JSON data, do
//
//     final categoryDetailModel = categoryDetailModelFromJson(jsonString);

import 'dart:convert';

CategoryDetailModel categoryDetailModelFromJson(String str) =>
    CategoryDetailModel.fromJson(json.decode(str));

String categoryDetailModelToJson(CategoryDetailModel data) =>
    json.encode(data.toJson());

class CategoryDetailModel {
  CategoryDetailModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  dynamic message;
  Data data;

  factory CategoryDetailModel.fromJson(Map<String, dynamic> json) =>
      CategoryDetailModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    this.basketCount,
    this.mainCategories,
  });

  int basketCount;
  List<Category> mainCategories;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        basketCount: json["basketCount"] == null ? null : json["basketCount"],
        mainCategories: json["mainCategories"] == null
            ? null
            : List<Category>.from(
                json["mainCategories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "basketCount": basketCount == null ? null : basketCount,
        "mainCategories": mainCategories == null
            ? null
            : List<dynamic>.from(mainCategories.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    this.selected,
    this.id,
    this.name,
    this.subCategories,
    this.products,
  });

  bool selected;
  String id;
  String name;
  List<Category> subCategories;
  List<Product> products;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        selected: json["selected"] == null ? null : json["selected"],
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        subCategories: json["subCategories"] == null
            ? null
            : List<Category>.from(
                json["subCategories"].map((x) => Category.fromJson(x))),
        products: json["products"] == null
            ? null
            : List<Product>.from(
                json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "selected": selected == null ? null : selected,
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "subCategories": subCategories == null
            ? null
            : List<dynamic>.from(subCategories.map((x) => x.toJson())),
        "products": products == null
            ? null
            : List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    this.id,
    this.name,
    this.liked,
    this.originalPrice,
    this.discountedPrice,
    this.discountRate,
    this.amount,
  });

  String id;
  String name;
  bool liked;
  int originalPrice;
  int discountedPrice;
  int discountRate;
  int amount;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        liked: json["liked"] == null ? null : json["liked"],
        originalPrice:
            json["originalPrice"] == null ? null : json["originalPrice"],
        discountedPrice:
            json["discountedPrice"] == null ? null : json["discountedPrice"],
        discountRate:
            json["discountRate"] == null ? null : json["discountRate"],
        amount: json["amount"] == null ? null : json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "liked": liked == null ? null : liked,
        "originalPrice": originalPrice == null ? null : originalPrice,
        "discountedPrice": discountedPrice == null ? null : discountedPrice,
        "discountRate": discountRate == null ? null : discountRate,
        "amount": amount == null ? null : amount,
      };
}
