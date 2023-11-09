import 'package:calpal2/pages/home_page.dart';
import 'package:calpal2/pages/settings/settings_page_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('settings_title')),
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
                            Text(tr('settings_personal_info')),
                            const SizedBox(height: 20),
                            TextField(
                              controller: bloc.nameController,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: tr('settings_name'),
                              ),
                            ),
                            const SizedBox(height: 10),
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(tr('settings_sex')),
                                  Radio(
                                    value: true,
                                    groupValue: bloc.isMale,
                                    onChanged: (value) => bloc.isMale = value,
                                  ),
                                  Text(tr('settings_male')),
                                  const SizedBox(
                                    height: 24,
                                    child: VerticalDivider(width: 30, thickness: 1)
                                  ),
                                  Radio(
                                    value: false,
                                    groupValue: bloc.isMale,
                                    onChanged: (value) => bloc.isMale = value,
                                  ),
                                  Text(tr('settings_female')),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: bloc.ageController,
                              keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: tr('settings_age'),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: bloc.heightController,
                              keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: tr('settings_height'),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: bloc.weightController,
                              keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: tr('settings_weight'),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(tr('settings_fitness_data')),
                            const SizedBox(height: 20),
                            SizedBox(width: double.infinity,
                              child: Column(children: [
                                Text(tr('settings_activity_level'), textAlign: TextAlign.start),
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
                                Text(tr('settings_diet_goal'), textAlign: TextAlign.start),
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
                                child: Text(tr('btn_save')),
                                
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