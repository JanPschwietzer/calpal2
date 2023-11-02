import 'package:calpal2/pages/calorietracker/calorietracker_page.dart';
import 'package:calpal2/pages/habits/add_habit/add_habit_page.dart';
import 'package:calpal2/pages/habits/habits_page.dart';
import 'package:calpal2/pages/settings/settings_page.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  final int index;
  const HomePage({this.index = 0, super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CalPal'),
        actions: [
          if (_currentIndex == 0) IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SettingsPage())),
          ),
          if (_currentIndex == 1) IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AddHabitPage())),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          CalorieTrackerPage(),
          HabitsPage(),
          Placeholder(),
          Placeholder()
        ],
      ),
      bottomNavigationBar: NavigationBar(destinations: const [
        NavigationDestination(
          icon: Icon(Icons.donut_large),
          label: 'Calorie Tracker',
        ),
        NavigationDestination(
          icon: Icon(Icons.fitness_center), 
          label: 'Habit Tracker',
        ),
        NavigationDestination(
          icon: Icon(Icons.medication),
          label: 'Supplement Tracker',
        ),
        NavigationDestination(
          icon: Icon(Icons.calendar_month),
          label: 'Show History',
        ),
      ],
      selectedIndex: _currentIndex,
      indicatorColor: const Color.fromARGB(32, 37, 61, 120),
      onDestinationSelected: _onItemTapped,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index;
  }
}