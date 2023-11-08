import 'package:uuid/uuid.dart';

enum HabitFrequency {
  daily,
  weekly,
  monthly,
  yearly,
}

class DatabaseHabit {
  static const uuid = Uuid();

  String? id;
  String name;
  String description;
  int frequencyNumber;
  HabitFrequency frequency;
  DateTime? lastTimeFinished;
  int streak = 0;

  DatabaseHabit({
    this.id = '',
    required this.name,
    required this.description,
    required this.frequencyNumber,
    required this.frequency,
    this.lastTimeFinished,
    this.streak = 0,
  }) {
        if (id == '') {
      id = uuid.v1();
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'frequencyNumber': frequencyNumber,
      'frequency': frequency,
      'lastTimeFinished': lastTimeFinished?.toIso8601String(),
      'streak': streak,
    };
  }
}