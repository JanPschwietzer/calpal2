import 'package:uuid/uuid.dart';

class DatabaseProduct {
  static const uuid = Uuid();

  String? id;
  String mealtime = ''; // "breakfast", "lunch", "dinner", "snack"
  String date = '';
  String name = '';
  String brand = '';
  int amount = 0;
  int calories = 0;
  double protein = 0;
  double carbs = 0;
  double sugar = 0;
  double fat = 0;
  double saturatedFat = 0;
  double fiber = 0;
  double salt = 0;
  String image = '';

  DatabaseProduct({
    this.id = '',
    required this.mealtime,
    required this.date,
    required this.name,
    required this.brand,
    required this.amount,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.sugar,
    required this.fat,
    required this.saturatedFat,
    required this.fiber,
    required this.salt,
    required this.image,
  }) {
    if (id == '') {
      id = uuid.v1();
    }
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "mealtime": mealtime, // "breakfast", "lunch", "dinner", "snack"
      "date": date,
      "name": name,
      "brand": brand,
      "amount": amount,
      "calories": calories,
      "protein": protein,
      "carbs": carbs,
      "sugar": sugar,
      "fat": fat,
      "saturatedFat": saturatedFat,
      "fiber": fiber,
      "salt": salt,
      "image": image,
    };
  }
}
