import 'package:calpal2/models/db_habit.dart';
import 'package:calpal2/pages/habits/edit_habit/edit_habit_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditHabitPage extends StatelessWidget {
  final DatabaseHabit habit;
  const EditHabitPage({Key? key, required this.habit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gewohnheit ändern'),
      ),
      body: ChangeNotifierProvider(
        create: (context) => EditHabitPageBloc(habit),
        child: Consumer<EditHabitPageBloc>(builder: (context, bloc, child) =>
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                const Text("Generelle Informationen"),
                const SizedBox(height: 20),
                TextField(
                  controller: bloc.nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: bloc.descriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Beschreibung',
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: bloc.frequencyNumberController,
                        keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Häufigkeit',
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: DropdownButton<String>(
                          value: bloc.selectedFrequency,
                          onChanged: (value) => { bloc.selectedFrequency = value },
                          items: HabitFrequency.values.map((HabitFrequency frequency) {
                            return DropdownMenuItem<String>(
                              value: bloc.getFrequencyString(frequency),
                              child: Text(bloc.getFrequencyString(frequency)),
                            );
                          }).toList(),
                          isExpanded: true,
                          iconSize: 42,
                          underline: const SizedBox(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => bloc.saveHabit(context, habit),
                  child: const Text('Speichern'),
                ),
              ]),
          )
        )
    )));
  }
}