import 'package:calpal2/pages/home_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AddHabitPage extends StatelessWidget {
  const AddHabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(tr('habit_add_title')),
        actions: [
          IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage(index: 1))
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