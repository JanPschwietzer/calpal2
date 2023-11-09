import 'package:calpal2/models/db_habit.dart';
import 'package:calpal2/pages/habits/edit_habit/edit_habit_page.dart';
import 'package:easy_localization/easy_localization.dart';
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
    DatabaseHabit(name: "Selbst kochen", description: "Eine gesunde Mahlzeit kochen", frequencyNumber: 1, frequency: HabitFrequency.daily, lastTimeFinished: DateTime(2023, 11, 7), streak: 1),
    DatabaseHabit(name: "Sport treiben", description: "Im Fitnessstudio", frequencyNumber: 3, frequency: HabitFrequency.daily, lastTimeFinished: DateTime(2023, 11, 7), streak: 9),
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

  void editHabit(int index, BuildContext context) async {
    if (!context.mounted) {
      return;
    }
    final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditHabitPage(habit: habits[index])));

    if (result != null) {
      habits[index] = result;
      checkSteaks();
      notifyListeners();
    }
  }

  void checkSteaks() {
    for (DatabaseHabit habit in habits) {
      if (!checkStreakWillSurvive(habit)) {
        habit.streak = 0;
      }
    }
  }

  String getDueDate(int index) {
    DatabaseHabit habit = habits[index];
    int days = 0;

    if (habit.lastTimeFinished == null) {
      return tr('habit_due_today');
    }

    switch(habit.frequency) {
      case (HabitFrequency.daily):
        days = habit.lastTimeFinished!.add(Duration(days: habit.frequencyNumber + 1)).difference(DateTime.now()).inDays;
        break;
      case (HabitFrequency.weekly):
        days = habit.lastTimeFinished!.add(Duration(days: (habit.frequencyNumber + 1) * 7)).difference(DateTime.now()).inDays;
        break;
      case (HabitFrequency.monthly):
        days = habit.lastTimeFinished!.add(Duration(days: (habit.frequencyNumber + 1) * 30)).difference(DateTime.now()).inDays;
        break;
      case (HabitFrequency.yearly):
        days = habit.lastTimeFinished!.add(Duration(days: (habit.frequencyNumber + 1) * 365)).difference(DateTime.now()).inDays;
        break;
    }

    if (days <= 0) {
      return tr('habit_due_today');
    } else if (days == 1) {
      return tr('habit_due_tomorrow');
    } else if (days > 1) {
      return tr('habit_due_in_days', args: [days.abs().toString()]);
    }
    return '';
  }

  bool checkStreakWillSurvive(DatabaseHabit habit) {
    if (habit.lastTimeFinished == null) {
      return true;
    }

    if (habit.frequency == HabitFrequency.daily) {
      return habit.lastTimeFinished!.add(Duration(days: habit.frequencyNumber)).isAfter(DateTime.now().subtract(const Duration(days: 1)));
    } else if (habit.frequency == HabitFrequency.weekly) {
      return habit.lastTimeFinished!.add(Duration(days: habit.frequencyNumber * 7)).isAfter(DateTime.now().subtract(const Duration(days: 7)));
    } else if (habit.frequency == HabitFrequency.monthly) {
      return habit.lastTimeFinished!.add(Duration(days: habit.frequencyNumber * 30)).isAfter(DateTime.now().subtract(const Duration(days: 30)));
    }
    return true;
  }

  bool checkTaskEnabled(int index) {
    DatabaseHabit habit = habits[index];

    if (habit.lastTimeFinished == null) {
      return true;
    }
    return habit.lastTimeFinished!.add(const Duration(days: 1)).isBefore(DateTime.now());
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

  HabitsPageBloc() {
    checkSteaks();
  }


}