// To parse this JSON data, do
//
//     final marketProductsModel = marketProductsModelFromJson(jsonString);

import 'dart:convert';

MarketProductsModel marketProductsModelFromJson(String str) => MarketProductsModel.fromJson(json.decode(str));

String marketProductsModelToJson(MarketProductsModel data) => json.encode(data.toJson());

class MarketProductsModel {
    MarketProductsModel({
        this.success,
        this.message,
        this.data,
    });

    bool success;
    dynamic message;
    Data data;

    factory MarketProductsModel.fromJson(Map<String, dynamic> json) => MarketProductsModel(
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
        this.id,
        this.name,
        this.phone,
        this.categories,
    });

    String id;
    String name;
    dynamic phone;
    List<Category> categories;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        phone: json["phone"],
        categories: json["categories"] == null ? null : List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "phone": phone,
        "categories": categories == null ? null : List<dynamic>.from(categories.map((x) => x.toJson())),
    };
}

class Category {
    Category({
        this.id,
        this.name,
        this.products,
    });

    String id;
    String name;
    List<Product> products;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        products: json["products"] == null ? null : List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "products": products == null ? null : List<dynamic>.from(products.map((x) => x.toJson())),
    };
}

class Product {
    Product({
        this.id,
        this.name,
        this.originalPrice,
        this.discountedPrice,
        this.discountRate,
        this.amount,
    });

    String id;
    String name;
    int originalPrice;
    int discountedPrice;
    int discountRate;
    int amount;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        originalPrice: json["originalPrice"] == null ? null : json["originalPrice"],
        discountedPrice: json["discountedPrice"] == null ? null : json["discountedPrice"],
        discountRate: json["discountRate"] == null ? null : json["discountRate"],
        amount: json["amount"] == null ? null : json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "originalPrice": originalPrice == null ? null : originalPrice,
        "discountedPrice": discountedPrice == null ? null : discountedPrice,
        "discountRate": discountRate == null ? null : discountRate,
        "amount": amount == null ? null : amount,
    };
}
