import 'package:calpal2/models/db_habit.dart';
import 'package:flutter/foundation.dart';

class HabitsPageBloc extends ChangeNotifier {

  List<DatabaseHabit> _habits = [
    DatabaseHabit(name: "Test", description: "Fisch", frequency: HabitFrequency.daily, datetime: DateTime.now(), icon: "sword"),
    DatabaseHabit(name: "Test2", description: "Fisch3", frequency: HabitFrequency.daily, datetime: DateTime.now(), icon: "mdiAccountArrowDown"),
  ];
  get habits => _habits;
  set habits(value) {
    _habits = value;
    notifyListeners();
  }
}