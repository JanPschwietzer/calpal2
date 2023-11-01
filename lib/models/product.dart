// To parse this JSON data, do
//
//     final openFoodFacts = openFoodFactsFromJson(jsonString);

import 'dart:convert';

OpenFoodFacts openFoodFactsFromJson(String str) => OpenFoodFacts.fromJson(json.decode(str));

String openFoodFactsToJson(OpenFoodFacts data) => json.encode(data.toJson());

class OpenFoodFacts {
    Product? product;
    int? status;

    OpenFoodFacts({
        this.product,
        this.status,
    });

    factory OpenFoodFacts.fromJson(Map<String, dynamic> json) => OpenFoodFacts(
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "product": product?.toJson(),
        "status": status,
    };
}

class Product {
    String? brands;
    String? imageFrontUrl;
    String? nutriscoreGrade;
    String? productName;
    dynamic servingQuantity;
    String? genericName;
    Nutriments? nutriments;

    Product({
        this.brands,
        this.imageFrontUrl,
        this.nutriscoreGrade,
        this.productName,
        this.servingQuantity,
        this.genericName,
        this.nutriments,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        brands: json["brands"],
        imageFrontUrl: json["image_front_url"],
        nutriscoreGrade: json["nutriscore_grade"],
        productName: json["product_name"],
        servingQuantity: json["serving_quantity"],
        genericName: json["generic_name"],
        nutriments: json["nutriments"] == null ? null : Nutriments.fromJson(json["nutriments"]),
    );

    Map<String, dynamic> toJson() => {
        "brands": brands,
        "image_front_url": imageFrontUrl,
        "nutriscore_grade": nutriscoreGrade,
        "product_name": productName,
        "serving_quantity": servingQuantity,
        "generic_name": genericName,
        "nutriments": nutriments?.toJson(),
    };
}

class Nutriments {
    num? energyKcal100G;
    num? carbohydrates100G;
    num? fat100G;
    num? proteins100G;
    num? salt100G;
    num? saturatedFat100G;
    num? sugars100G;
    num? fiber100G;

    Nutriments({
        this.energyKcal100G,
        this.carbohydrates100G,
        this.fat100G,
        this.proteins100G,
        this.salt100G,
        this.saturatedFat100G,
        this.sugars100G,
        this.fiber100G,
    });

    factory Nutriments.fromJson(Map<String, dynamic> json) => Nutriments(
        energyKcal100G: json["energy-kcal_100g"],
        carbohydrates100G: json["carbohydrates_100g"],
        fat100G: json["fat_100g"],
        proteins100G: json["proteins_100g"],
        salt100G: json["salt_100g"],
        saturatedFat100G: json["saturated-fat_100g"],
        sugars100G: json["sugars_100g"],
        fiber100G: json["fiber_100g"],
    );

    Map<String, dynamic> toJson() => {
        "energy-kcal_100g": energyKcal100G,
        "carbohydrates_100g": carbohydrates100G,
        "fat_100g": fat100G,
        "proteins_100g": proteins100G,
        "salt_100g": salt100G,
        "saturated-fat_100g": saturatedFat100G,
        "sugars_100g": sugars100G,
        "fiber_100g": fiber100G,
    };
}
