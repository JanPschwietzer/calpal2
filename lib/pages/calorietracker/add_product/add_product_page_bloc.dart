import 'package:calpal2/backend/sqlite.dart';
import 'package:calpal2/models/db_product.dart';
import 'package:calpal2/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddProductPageBloc extends ChangeNotifier {

  AddProductPageBloc(String barcode, BuildContext context) {
    getProductData(barcode, context);
    dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  void getProductData(String barcode, BuildContext context) {
    if (barcode == '') {
      product = OpenFoodFacts();
      return;
    }
    http.get(Uri.https('world.openfoodfacts.org', '/api/v0/product/$barcode.json')).then((value) {
      if (value.statusCode == 200) {
        product = openFoodFactsFromJson(value.body);
        product.status == 0 ? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Produkt nicht gefunden. Bitte füge es manuell hinzu.'))) : null;
      }
      else {
        product = OpenFoodFacts();
      }
    }).whenComplete(() {
      setData();
    });
  }

  void addProduct(BuildContext context) {

    int amount = int.tryParse(amountController.text) ?? 0;

    SQLiteDatabase.insertProduct(
      DatabaseProduct(
        mealtime: selectedMeal, 
        date: dateController.text,
        name: productNameController.text, 
        brand: brandNameController.text, 
        amount: amount, 
        calories: ((int.tryParse(caloriesController.text) ?? 0) / 100 * amount).toInt(), 
        protein: (double.tryParse(proteinController.text) ?? 0) / 100 * amount,
        carbs: (double.tryParse(carbsController.text) ?? 0) / 100 * amount, 
        sugar: (double.tryParse(sugarController.text) ?? 0) / 100 * amount, 
        fat: (double.tryParse(fatController.text) ?? 0) / 100 * amount, 
        saturatedFat: (double.tryParse(saturatedFatController.text) ?? 0) / 100 * amount, 
        fiber: (double.tryParse(fiberController.text) ?? 0) / 100 * amount, 
        salt: (double.tryParse(saltController.text) ?? 0) / 100 * amount, 
        image: product.product?.imageFrontUrl ?? '',
      )
    );
    Navigator.pop(context);
  }

  void setData() {
    if (product.product != null) {
      brandNameController.text = product.product!.brands ?? '';
      productNameController.text = product.product!.productName ?? product.product!.genericName ?? '';
      if (product.product.nutriments != null) {
        caloriesController.text = product.product!.nutriments!.energyKcal100G.toString();
        carbsController.text = product.product!.nutriments!.carbohydrates100G.toString();
        sugarController.text = product.product!.nutriments!.sugars100G.toString();
        fatController.text = product.product!.nutriments!.fat100G.toString();
        saturatedFatController.text = product.product!.nutriments!.saturatedFat100G.toString();
        proteinController.text = product.product!.nutriments!.proteins100G.toString();
        fiberController.text = product.product!.nutriments!.fiber100G.toString();
        saltController.text = product.product!.nutriments!.salt100G.toString();
        amountController.text = product.product!.servingQuantity.toString() == 'null' ? '100' : product.product!.servingQuantity.toString();
      }
    }
  }

  void selectDate(BuildContext context) async {
    DateTime? date = await showDatePicker(
        context: context,
          initialDate: DateTime.now(),
        firstDate:DateTime(2000),
        lastDate: DateTime.now(),
    );
    if (date != null) {
      dateController.text = DateFormat('yyyy-MM-dd').format(date);
    }
  }

  OpenFoodFacts _product = OpenFoodFacts();
  get product => _product;
  set product(value) {
    _product = value;
    notifyListeners();
  }

  final _productNameController = TextEditingController();
  get productNameController => _productNameController;

  final _brandNameController = TextEditingController();
  get brandNameController => _brandNameController;

  final _dateController = TextEditingController();
  get dateController => _dateController;

  final _caloriesController = TextEditingController();
  get caloriesController => _caloriesController;

  final _carbsController = TextEditingController();
  get carbsController => _carbsController;

  final _sugarController = TextEditingController();
  get sugarController => _sugarController;
  
  final _fatController = TextEditingController();
  get fatController => _fatController;

  final _saturatedFatController = TextEditingController();
  get saturatedFatController => _saturatedFatController;

  final _proteinController = TextEditingController();
  get proteinController => _proteinController;

  final _fiberController = TextEditingController();
  get fiberController => _fiberController;

  final _saltController = TextEditingController();
  get saltController => _saltController;

  final _amountController = TextEditingController();
  get amountController => _amountController;


  final _mealList = ['Frühstück', 'Mittagessen', 'Abendessen', 'Snack'];
  get mealList => _mealList;

  String _selectedMeal = 'Frühstück';
  get selectedMeal => _selectedMeal;
  set selectedMeal(value) {
    _selectedMeal = value;
    notifyListeners();
  }

}