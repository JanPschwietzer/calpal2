import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class DatabaseProduct {
  static const uuid = Uuid();

  String? id = uuid.v1();
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
    this.id,
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
  });

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

class SQLiteDatabase {
  static Database? database;

  //initialize database
  static Future<void> init() async {
    database = await openDatabase(join(await getDatabasesPath(), 'calpal.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE eaten_products(id TEXT PRIMARY KEY, mealtime TEXT, date TEXT, name TEXT, brand TEXT, amount INTEGER, calories INTEGER, protein REAL, carbs REAL, sugar REAL, fat REAL, saturatedFat REAL, fiber REAL, salt REAL, image TEXT)'
        );
      },
      version: 1,
    );
  }

  static Future<void> insertProduct(DatabaseProduct product) async {
    if (database == null) {
      await init();
    }

    await database!.insert(
      'eaten_products',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getProducts(String date) async {
    if (database == null) {
      await init();
    }
    return await database!.query(
      'eaten_products',
      where: 'date = ?',
      whereArgs: [date],
    );
  }

  static Future<DatabaseProduct> getProduct(String id) async {
    if (database == null) {
      await init();
    }
    Map<String, dynamic> product = await database!.query(
      'eaten_products',
      where: 'id = ?',
      whereArgs: [id],
    ).then((value) => value.first);
    return DatabaseProduct(
      id: product.containsKey('id') ? product['id'] : '',
      mealtime: product.containsKey('mealtime') ? product['mealtime'] : '',
      date: product.containsKey('date') ? product['date'] : '',
      name: product.containsKey('name') ? product['name'] : '',
      brand: product.containsKey('brand') ? product['brand'] : '',
      amount: product.containsKey('amount') ? product['amount'] : 0,
      calories: product.containsKey('calories') ? product['calories'] : 0,
      protein: product.containsKey('protein') ? product['protein'] : 0,
      carbs: product.containsKey('carbs') ? product['carbs'] : 0,
      sugar:  product.containsKey('sugar') ? product['sugar'] : 0,
      fat: product.containsKey('fat') ? product['fat'] : 0,
      saturatedFat: product.containsKey('saturatedFat') ? product['saturatedFat'] : 0,
      fiber: product.containsKey('fiber') ? product['fiber'] : 0,
      salt: product.containsKey('salt') ? product['salt'] : 0,
      image: product.containsKey('image') ? product['image'] : '',
    );
  }

  static Future<void> updateProduct(DatabaseProduct product) async {
    if (database == null) {
      await init();
    }
    await database!.update(
      'eaten_products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  static Future<void> deleteProduct(String id) async {
    if (database == null) {
      await init();
    }
    await database!.delete(
      'eaten_products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}