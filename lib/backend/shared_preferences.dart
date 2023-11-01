import 'package:calpal2/models/user_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static late final SharedPreferences _sharedPreferences;

  static void setUserData(UserSettings userSettings) {
    _sharedPreferences.setString('name', userSettings.name);
    _sharedPreferences.setBool('isMale', userSettings.isMale);
    _sharedPreferences.setInt('age', userSettings.age);
    _sharedPreferences.setInt('height', userSettings.height);
    _sharedPreferences.setInt('weight', userSettings.weight);
    _sharedPreferences.setInt('activityLevel', userSettings.activityLevel.index);
    _sharedPreferences.setInt('dietGoal', userSettings.dietGoal.index);
    _sharedPreferences.setInt('goalCalories', userSettings.goalCalories);
  }

  static UserSettings getUserData() {
    return UserSettings(
      name: _sharedPreferences.getString('name') ?? '',
      isMale: _sharedPreferences.getBool('isMale') ?? true,
      age: _sharedPreferences.getInt('age') ?? 0,
      height: _sharedPreferences.getInt('height') ?? 0,
      weight: _sharedPreferences.getInt('weight') ?? 0,
      activityLevel: ActivityLevel.values[_sharedPreferences.getInt('activityLevel') ?? 0],
      dietGoal: DietGoal.values[_sharedPreferences.getInt('dietGoal') ?? 2],
      goalCalories: _sharedPreferences.getInt('goalCalories') ?? 0,
    );
  }

  //initialize database
  static void init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  UserData() {
    init();
  }
}