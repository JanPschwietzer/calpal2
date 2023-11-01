import 'package:calpal2/pages/home_page.dart';
import 'package:flutter/material.dart';

class AddHabitPage extends StatelessWidget {
  const AddHabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Add Habit'),
        actions: [
          IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(index: 1))
          )
        ),
        ],
      ),
      body: const Center(
        child: Text('Add Habit Page'),
      ),
    );
  }
}