import 'package:calpal2/pages/habits/habits_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HabitsPage extends StatelessWidget {
  const HabitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => HabitsPageBloc(),
        child: Consumer<HabitsPageBloc>(builder: (context, bloc, child) => 
        Expanded(
          child: SingleChildScrollView(
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const SizedBox(height: 20),
                const Text('Gewohnheiten'),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: bloc.habits.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(bloc.habits[index].name),
                    subtitle: Text(bloc.habits[index].description),
                    leading: SizedBox(
                      width: 60,
                      height: 60,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(45),
                        ),
                        child: const Center(child: Text("1.500", style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        
                        )),)
                      ),
                    ),
                    trailing: Wrap(
                      spacing: 12,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.check_box_outline_blank),
                          onPressed: () => {},
                        ),
                      ]
                    ),
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}