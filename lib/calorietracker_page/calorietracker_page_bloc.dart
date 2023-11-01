import 'package:calpal2/backend/shared_preferences.dart';
import 'package:calpal2/backend/sqlite.dart';
import 'package:calpal2/calorietracker_page/add_product/add_product_page.dart';
import 'package:calpal2/helper_widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_barcode_scanner/enum.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}

class CalorieTrackerPageBloc extends ChangeNotifier {

  CalorieTrackerPageBloc() {
    updateAllData();
  }

  final _searchController = TextEditingController();
  get searchController => _searchController;

  final _userData = UserData.getUserData();
  get userData => _userData;

  int _goalCalories = 2000;
  get goalCalories => _goalCalories;
  set goalCalories(value) {
    _goalCalories = value;
    notifyListeners();
  }

  int _eatenCalories = 0;
  get eatenCalories => _eatenCalories;
  set eatenCalories(value) {
    _eatenCalories = value;
    notifyListeners();
  }

  List<ChartData> _calorieData = [
    ChartData('Eaten', 0),
    ChartData('Left', 2000),
  ];
  get calorieData => _calorieData;
  set calorieData(value) {
    _calorieData = value;
    notifyListeners();
  }

  List<Map<String, dynamic>> _products = [];
  get products => _products;
  set products(value) {
    _products = value;
    int calories = 0;

    for (Map<String, dynamic> product in _products) {
        calories += product['calories'] as int;
    }
    eatenCalories = calories;
    updateAllData();
    notifyListeners();
  }

  void updateAllData() {
    updateProducts();
    updateCalorieGoal();
    updateCalorieData();
  }

  void updateProducts() {
    SQLiteDatabase.getProducts(DateFormat('yyyy-MM-dd').format(DateTime.now())).then((value) {
      products = value;
    });
  }

  void updateCalorieGoal() {
    goalCalories = userData.goalCalories != 0 ? userData.goalCalories : 2000;
  }

  void updateCalorieData() {
    calorieData = [
      ChartData('Eaten', eatenCalories.toDouble()),
      ChartData('Left', goalCalories.toDouble() - eatenCalories.toDouble()),
    ];
  }

  void searchProduct(BuildContext context) {
    if (_searchController.text.isEmpty) {
      showSnackBar(context, 'Feld ist leer!');
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => AddProductPage(tabKey: searchController.text))).then((value) => updateCalorieData());
    }
  }

  void scanBarcode(BuildContext context) async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => const SimpleBarcodeScannerPage(
      appBarTitle: 'Barcode scannen',
      scanType: ScanType.barcode,
    )));

    if (result == null) {
      if (context.mounted) showSnackBar(context, 'Barcode wurde nicht gescannt!');
    } else {
      if (context.mounted) Navigator.push(context, MaterialPageRoute(builder: (context) => AddProductPage(tabKey: result))).then((value) => updateCalorieData());
    }
  }

}