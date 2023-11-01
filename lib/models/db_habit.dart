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
  HabitFrequency frequency;
  DateTime datetime;
  String icon;

  DatabaseHabit({
    this.id = '',
    required this.name,
    required this.description,
    required this.frequency,
    required this.datetime,
    required this.icon,
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
      'frequency': frequency,
      'datetime': datetime,
      'icon': icon,
    };
  }
}