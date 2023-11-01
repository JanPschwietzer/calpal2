import 'package:calpal2/calorietracker_page/calorietracker_page.dart';
import 'package:calpal2/settings_page/settings_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CalPal'),
        actions: [
          _currentPage == 0 ? IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SettingsPage())),
          ) : const SizedBox(),
        ],
      ),
      body: IndexedStack(
        index: _currentPage,
        children: const [
          CalorieTrackerPage(),
          Placeholder(),
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
      selectedIndex: _currentPage,
      indicatorColor: const Color.fromARGB(32, 37, 61, 120),
      onDestinationSelected: _onItemTapped,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentPage = index;
    });
  }
}