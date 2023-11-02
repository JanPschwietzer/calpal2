import 'package:calpal2/pages/home_page.dart';
import 'package:calpal2/pages/settings/settings_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Einstellungen'),
        actions: [IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage())),
        )]
      ),
      body: ChangeNotifierProvider(
        create: (context) => SettingsPageBloc(),
        child: Consumer<SettingsPageBloc>(
          builder: (context, bloc, child) => SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(width: double.infinity,
                  child: Column(
                    children: [
                      Padding(padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            const Text('Persönliche Daten'),
                            const SizedBox(height: 20),
                            TextField(
                              controller: bloc.nameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Name',
                              ),
                            ),
                            const SizedBox(height: 10),
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Geschlecht:'),
                                  Radio(
                                    value: true,
                                    groupValue: bloc.isMale,
                                    onChanged: (value) => bloc.isMale = value,
                                  ),
                                  const Text('Männlich'),
                                  const SizedBox(
                                    height: 24,
                                    child: VerticalDivider(width: 30, thickness: 1)
                                  ),
                                  Radio(
                                    value: false,
                                    groupValue: bloc.isMale,
                                    onChanged: (value) => bloc.isMale = value,
                                  ),
                                  const Text('Weiblich'),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: bloc.ageController,
                              keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Alter',
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: bloc.heightController,
                              keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Größe (in cm)',
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: bloc.weightController,
                              keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Gewicht (in kg)',
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text('Fitnessbezogene Daten'),
                            const SizedBox(height: 20),
                            SizedBox(width: double.infinity,
                              child: Column(children: [
                                const Text('Aktivitätslevel auf der Arbeit:', textAlign: TextAlign.start),
                                Text(bloc.activityLevelText ?? '', textAlign: TextAlign.start, style: const TextStyle(fontSize: 12),),
                              ],),
                            ),
                            Slider(value: bloc.activityLevel.index.toDouble(), onChanged: ((value) => bloc.activityLevel = value),
                              min: 0, max: 3, divisions: 3,
                              label: bloc.activityLevelText,
                            ),
                            const SizedBox(height: 20),
                            SizedBox(width: double.infinity,
                              child: Column(children: [
                                const Text('Diätziel', textAlign: TextAlign.start),
                                Text(bloc.dietGoalText ?? '', textAlign: TextAlign.start, style: const TextStyle(fontSize: 12),),
                              ],),
                            ),
                            Slider(value: bloc.dietGoal.index.toDouble(), onChanged: ((value) => bloc.dietGoal = value),
                              min: 0, max: 4, divisions: 4,
                              label: bloc.dietGoalText,
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 80,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => bloc.saveSettings(context),
                                style: ButtonStyle(fixedSize: MaterialStateProperty.all(const Size.fromHeight(62)),
                                  backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
                                  foregroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onPrimary)
                                ),
                                child: const Text('Speichern'),
                                
                              ),
                            ),
                            const SizedBox(height: 40),
                          ]
                        ),
                      ),
                    ],
                  ),
                ),
              ]
            ),
          ),
        ),
        ),
    );
  }
}