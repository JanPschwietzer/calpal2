import 'package:calpal2/pages/habits/habits_page_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HabitsPage extends StatelessWidget {
  const HabitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => HabitsPageBloc(),
        child: Consumer<HabitsPageBloc>(builder: (context, bloc, child) => 
        Column(
          children: [
            const SizedBox(height: 20),
            Text(tr('habit_title')),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: bloc.habits.length,
                      itemBuilder: (context, index) => ListTile(
                        enabled: bloc.checkTaskEnabled(index),
                        title: Text(bloc.habits[index].name.length > 22 ? bloc.habits[index].name.substring(0, 22) + '...' : bloc.habits[index].name),
                        subtitle: Text(bloc.getDueDate(index)),
                        leading: SizedBox(
                          width: 70,
                          height: 50,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: bloc.getStreakColor(bloc.habits[index].streak),
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.black12, width: 1),
                            ),
                            child: Center(child: Text(bloc.habits[index].streak.toString(), style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            
                            )),)
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => { bloc.editHabit(index, context)},
                        ),
                        onLongPress: () => { bloc.finishTask(index)},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )));
  }
}