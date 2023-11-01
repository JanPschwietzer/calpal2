import 'package:calpal2/backend/shared_preferences.dart';
import 'package:calpal2/home_page.dart';
import 'package:calpal2/models/user_settings.dart';
import 'package:flutter/material.dart';

class SettingsPageBloc extends ChangeNotifier {

  final _nameController = TextEditingController();
  get nameController => _nameController;

  final _ageController = TextEditingController();
  get ageController => _ageController;

  final _heightController = TextEditingController();
  get heightController => _heightController;

  final _weightController = TextEditingController();
  get weightController => _weightController;

  bool _isMale = true;
  get isMale => _isMale;
  set isMale(value) {
    _isMale = value;
    notifyListeners();
  }

  num _baseCalories = 0;
  get baseCalories => _baseCalories;
  set baseCalories(value) {
    _baseCalories = value;
    notifyListeners();
  }

  DietGoal _dietGoal = DietGoal.maintainWeight;
  get dietGoal => _dietGoal;
  set dietGoal(value) {
    if (value is DietGoal) {
      _dietGoal = value;
    } else
    {
      _dietGoal = DietGoal.values[value.toInt()];
    }
    setDietGoalText();
    notifyListeners();
  }

  String _dietGoalText = '';
  get dietGoalText => _dietGoalText;
  set dietGoalText(value) {
    _dietGoalText = value;
    notifyListeners();
  }

  void setDietGoalText() {
    if (dietGoal == DietGoal.gainWeightFast) {
      dietGoalText = '+0,5 kg pro Woche';
    } else if (dietGoal == DietGoal.gainWeight) {
      dietGoalText = '+0,25 kg pro Woche';
    } else if (dietGoal == DietGoal.maintainWeight) {
      dietGoalText = '0 kg pro Woche';
    } else if (dietGoal == DietGoal.loseWeight) {
      dietGoalText = '-0,25 kg pro Woche';
    } else if (dietGoal == DietGoal.loseWeightFast) {
      dietGoalText = '-0,5 kg pro Woche';
    }
    notifyListeners();
  }

  ActivityLevel _activityLevel = ActivityLevel.moderatelyActive;
  get activityLevel => _activityLevel;
  set activityLevel(value) {
    if (value is ActivityLevel) {
      _activityLevel = value;
    } else
    {
      _activityLevel = ActivityLevel.values[value.toInt()];
    }
    setActivityLevelText();
    notifyListeners();
  }

  String _activityLevelText = '';
  get activityLevelText => _activityLevelText;
  set activityLevelText(value) {
    _activityLevelText = value;
    notifyListeners();
  }

  void setActivityLevelText() {
    if (activityLevel == ActivityLevel.extraActive) {
      _activityLevelText = 'körperlich anstrengende Arbeit';
    } else if (activityLevel == ActivityLevel.veryActive) {
      _activityLevelText = 'hauptsächlich stehend und gehend';
    } else if (activityLevel == ActivityLevel.moderatelyActive) {
      _activityLevelText = 'überwiegend sitzend';
    } else if (activityLevel == ActivityLevel.lightlyActive) {
      _activityLevelText = 'sitzend';
    }
    notifyListeners();
  }

  SettingsPageBloc() {
    getSettings();
  }

  void saveSettings(BuildContext context) {
    UserData.setUserData(
      UserSettings(
        name: nameController.text,
        isMale: isMale,
        age: int.parse(ageController.text),
        height: int.parse(heightController.text),
        weight: int.parse(weightController.text),
        activityLevel: _activityLevel,
        dietGoal: _dietGoal,
        goalCalories: int.parse(calculateCalories().toString()),
      )
    );

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));

    getSettings();

  }

  void getSettings() {
    UserSettings userSettings = UserData.getUserData();
    _nameController.text = userSettings.name;
    _ageController.text = userSettings.age.toString();
    _heightController.text = userSettings.height.toString();
    _weightController.text = userSettings.weight.toString();
    isMale = userSettings.isMale;
    activityLevel = userSettings.activityLevel;
    dietGoal = userSettings.dietGoal;
    baseCalories = userSettings.goalCalories;

    notifyListeners();
  }

  num calculateCalories() {
    if (_ageController.text.isEmpty || _heightController.text.isEmpty || _weightController.text.isEmpty) {
      return -1;
    } else {
      int age = int.parse(_ageController.text);
      int height = int.parse(_heightController.text);
      int weight = int.parse(_weightController.text);
      int calorieSurplus = calculateCalorieSurplus();

      if (isMale) {
        double activityCalories = ((66.47 + (13.7 * weight) + (5 * height) - (6.8 * age)) / 24) * 5.5;
        double baseCalories = ((66.47 + (13.7 * weight) + (5 * height) - (6.8 * age)) / 24) * 18.5;

        if (activityLevel == ActivityLevel.extraActive) {
          return (baseCalories + (activityCalories * 2)).toInt() + calorieSurplus;
        } else if (activityLevel == ActivityLevel.veryActive) {
          return (baseCalories + (activityCalories * 1.8)).toInt() + calorieSurplus;
        } else if (activityLevel == ActivityLevel.moderatelyActive) {
          return (baseCalories + (activityCalories * 1.6)).toInt() + calorieSurplus;
        } else if (activityLevel == ActivityLevel.lightlyActive) {
          return (baseCalories + (activityCalories * 1.4)).toInt() + calorieSurplus;
        } else {
          return -1;
        }
      } else {
        double activityCalories = ((655.1 + (9.6 * weight) + (1.8 * height) - (4.7 * age)) / 24) * 5.5;
        double baseCalories = ((655.1 + (9.6 * weight) + (1.8 * height) - (4.7 * age)) / 24) * 18.5;

        if (activityLevel == ActivityLevel.extraActive) {
          return (baseCalories + activityCalories * 2).toInt() + calorieSurplus;
        } else if (activityLevel == ActivityLevel.veryActive) {
          return (baseCalories + activityCalories * 1.8).toInt() + calorieSurplus;
        } else if (activityLevel == ActivityLevel.moderatelyActive) {
          return (baseCalories + activityCalories * 1.6).toInt() + calorieSurplus;
        } else if (activityLevel == ActivityLevel.lightlyActive) {
          return (baseCalories + activityCalories * 1.4).toInt() + calorieSurplus;
        } else {
          return -1;
        }
      }
    }
  }

  int calculateCalorieSurplus() {
    if (dietGoal == DietGoal.gainWeightFast) {
      return 500;
    } else if (dietGoal == DietGoal.gainWeight) {
      return 250;
    } else if (dietGoal == DietGoal.maintainWeight) {
      return 0;
    } else if (dietGoal  == DietGoal.loseWeight) {
      return -250;
    } else {
      return -500;
    }
  }

}