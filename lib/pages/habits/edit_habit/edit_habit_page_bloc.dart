import 'package:calpal2/models/db_habit.dart';
import 'package:flutter/material.dart';

class EditHabitPageBloc extends ChangeNotifier {
  final _nameController = TextEditingController();
  get nameController => _nameController;
  final _descriptionController = TextEditingController();
  get descriptionController => _descriptionController;
  final _frequencyNumberController = TextEditingController();
  get frequencyNumberController => _frequencyNumberController;

  String getFrequencyString(HabitFrequency frequency) {
    switch (frequency) {
      case HabitFrequency.daily:
        return 'daily';
      case HabitFrequency.weekly:
        return 'weekly';
      case HabitFrequency.monthly:
        return 'monthly';
      case HabitFrequency.yearly:
        return 'yearly';
      default:
        return 'daily';
    }
  }

  void saveHabit(BuildContext context, DatabaseHabit habit) {
    int frequencyNumber = int.tryParse(frequencyNumberController.text) ?? 0;
    habit.name = nameController.text;
    habit.description = descriptionController.text;
    habit.frequencyNumber = frequencyNumber == 0 ? 1 : frequencyNumber;
    habit.frequency = HabitFrequency.values.firstWhere((element) => getFrequencyString(element) == selectedFrequency);
    Navigator.pop(context, habit);
  }

  late String _selectedFrequency;
  get selectedFrequency => _selectedFrequency;
  set selectedFrequency(value) {
    if (value is HabitFrequency) {
      _selectedFrequency = getFrequencyString(value);
    } else {
      _selectedFrequency = value;
    }
    notifyListeners();
  }

  late DatabaseHabit habit;

  EditHabitPageBloc(this.habit) {
    nameController.text = habit.name;
    descriptionController.text = habit.description;
    selectedFrequency = habit.frequency;
    frequencyNumberController.text = habit.frequencyNumber.toString();
  }
}