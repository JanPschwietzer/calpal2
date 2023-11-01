enum ActivityLevel {
  lightlyActive,
  moderatelyActive,
  veryActive,
  extraActive
}
enum DietGoal {
  loseWeightFast,
  loseWeight,
  maintainWeight,
  gainWeight,
  gainWeightFast
}

class UserSettings {
  final String name;
  final bool isMale;
  final int age;
  final int height;
  final int weight;
  final ActivityLevel activityLevel;
  final DietGoal dietGoal;
  final int goalCalories;

  const UserSettings({
    required this.name,
    required this.isMale,
    required this.age,
    required this.height,
    required this.weight,
    required this.activityLevel,
    required this.dietGoal,
    required this.goalCalories,
  });
}