import 'package:calpal2/models/db_habit.dart';
import 'package:flutter/material.dart';

enum StreakColor {
  bronce,
  silver,
  gold,
}

extension StreakColorExtension on StreakColor {
  Color get color {
    switch (this) {
      case StreakColor.bronce:
        return const Color(0xFFCD7F32);
      case StreakColor.silver:
        return const Color(0xFFC0C0C0);
      case StreakColor.gold:
        return const Color(0xFFFFD700);
      default:
        return Colors.transparent;
    }
  }
}

class HabitsPageBloc extends ChangeNotifier {

  List<DatabaseHabit> _habits = [
    DatabaseHabit(name: "Selbst kochen", description: "Eine gesunde Mahlzeit kochen", frequencyNumber: 3, frequency: HabitFrequency.daily, lastTimeFinished: DateTime(2023, 10, 30), streak: 0),
    DatabaseHabit(name: "Sport treiben", description: "Im Fitnessstudio", frequencyNumber: 1, frequency: HabitFrequency.daily, streak: 9),
  ];
  get habits => _habits;
  set habits(value) {
    _habits = value;
    notifyListeners();
  }

  void finishTask(int index) {
    habits[index].lastTimeFinished = DateTime.now();
    habits[index].streak++;
    notifyListeners();
  }

  bool checkTaskEnabled(int index) {
    
    DatabaseHabit habit = habits[index];

    if (habit.lastTimeFinished == null) {
      return true;
    }

    if (habit.frequency == HabitFrequency.daily) {
      return habit.lastTimeFinished!.add(Duration(days: habit.frequencyNumber)).isBefore(DateTime.now());
    } else if (habit.frequency == HabitFrequency.weekly) {
      return habit.lastTimeFinished!.add(Duration(days: habit.frequencyNumber * 7)).isBefore(DateTime.now());
    } else if (habit.frequency == HabitFrequency.monthly) {
      return habit.lastTimeFinished!.add(Duration(days: habit.frequencyNumber * 30)).isBefore(DateTime.now());
    }
    return true;
  }

  Color getStreakColor(int streak) {
    if (streak <= 5) {
      return Colors.transparent;
    } else if (streak < 10) {
      return StreakColor.bronce.color;
    } else if (streak < 20) {
      return StreakColor.silver.color;
    } else {
      return StreakColor.gold.color;
    }
  }



}