import 'package:calpal2/models/db_product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteDatabase {
  static Database? database;

  //initialize database
  static Future<void> init() async {
    database = await openDatabase(join(await getDatabasesPath(), 'calpal.db'),
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE eaten_products(id TEXT PRIMARY KEY, mealtime TEXT, date TEXT, name TEXT, brand TEXT, amount INTEGER, calories INTEGER, protein REAL, carbs REAL, sugar REAL, fat REAL, saturatedFat REAL, fiber REAL, salt REAL, image TEXT);
          CREATE TABLE habits(id TEXT PRIMARY KEY, name TEXT, description TEXT, frequency INTEGER, datetime TEXT, icon TEXT);
          CREATE TABLE supplements(id TEXT PRIMARY KEY, name TEXT, description TEXT, frequency INTEGER, datetime TEXT);
          ''',
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