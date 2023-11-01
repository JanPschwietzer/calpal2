import 'package:calpal2/backend/sqlite.dart';
import 'package:calpal2/models/db_product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditProductPageBloc extends ChangeNotifier {

  EditProductPageBloc(String id) {
    getProductData(id);
    dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  void getProductData(String id) {
    SQLiteDatabase.getProduct(id).then((value) {
      product = value;
    }).whenComplete(() {
      setTextFields();
    });
  }

  void setTextFields() {
    productNameController.text = product.name;
    brandNameController.text = product.brand;
    dateController.text = product.date;
    caloriesController.text = (product.calories / product.amount * 100).toInt().toString();
    proteinController.text = (product.protein / product.amount * 100).toStringAsFixed(2);
    carbsController.text = (product.carbs / product.amount * 100).toStringAsFixed(2);
    sugarController.text = (product.sugar / product.amount * 100).toStringAsFixed(2);
    fatController.text = (product.fat / product.amount * 100).toStringAsFixed(2);
    saturatedFatController.text = (product.saturatedFat / product.amount * 100).toStringAsFixed(2);
    fiberController.text = (product.fiber / product.amount * 100).toStringAsFixed(2);
    saltController.text = (product.salt / product.amount * 100).toStringAsFixed(2);
    amountController.text = product.amount.toString();
  }

  void addProduct(BuildContext context) {
    int amount = int.tryParse(amountController.text) ?? 0;

    SQLiteDatabase.updateProduct(
      DatabaseProduct(
        id: product.id,
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
        image: product.image
      )
    );
    Navigator.pop(context);
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

  DatabaseProduct _product = DatabaseProduct(mealtime: '', date: '', name: '', brand: '', amount: 0, calories: 0, protein: 0.0, carbs: 0.0, sugar: 0.0, fat: 0.0, saturatedFat: 0.0, fiber: 0.0, salt: 0.0, image: '');
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