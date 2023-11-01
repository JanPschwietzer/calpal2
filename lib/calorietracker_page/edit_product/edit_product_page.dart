import 'package:calpal2/calorietracker_page/edit_product/edit_product_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditProductPage extends StatelessWidget {
  final String tabKey;
  const EditProductPage({Key? key,required this.tabKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produkt ändern'),
      ),
      body: ChangeNotifierProvider(create: (context) => EditProductPageBloc(tabKey),
        child: Consumer<EditProductPageBloc>(builder: (context, bloc, child) =>
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                const Text("Generelle Informationen"),
                const SizedBox(height: 20),
                TextField(
                  controller: bloc.brandNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Markenname',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: bloc.productNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Produktname',
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: bloc.dateController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Datum',
                        ),
                        readOnly: true,
                        onTap: () => bloc.selectDate(context),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: DropdownButton<String>(
                          value: bloc.selectedMeal,
                          onChanged: (value) => bloc.selectedMeal = value!,
                          items: bloc.mealList.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value)
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
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                                      controller: bloc.amountController,
                                      keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Menge (in g)',
                                      ),
                                    ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          bloc.addProduct(context);
                        },
                        style: ButtonStyle(fixedSize: MaterialStateProperty.all(const Size.fromHeight(62)),
                          backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
                          foregroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onPrimary)
                        ),
                        child: const Text('Hinzufügen'),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                const SizedBox(
                  width: 200,
                  child: Divider(
                    height: 20,
                    thickness: 1,
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Nährwerte pro 100g"),
                const SizedBox(height: 20),
                Row(children: [
                  Expanded(
                    child: TextField(
                    controller: bloc.caloriesController,
                    keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Energie (kcal)',
                    ),
                                  ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: bloc.proteinController,
                      keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Protein',
                      ),
                    ),
                  ),
                ],),
                const SizedBox(height: 20),
                Row(children: [
                  Expanded(
                    child: TextField(
                    controller: bloc.carbsController,
                    keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Kohlenhydrate',
                    ),
                                  ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: bloc.sugarController,
                      keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'davon Zucker',
                      ),
                    ),
                  ),
                ],),
                const SizedBox(height: 20),
                Row(children: [
                  Expanded(
                    child: TextField(
                    controller: bloc.fatController,
                    keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Fette',
                    ),
                                  ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: bloc.saturatedFatController,
                      keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'gesättigte Fettsäuren',
                      ),
                    ),
                  ),
                ],),
                const SizedBox(height: 20),
                Row(children: [
                  Expanded(
                    child: TextField(
                    controller: bloc.fiberController,
                    keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Ballaststoffe',
                    ),
                                  ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: bloc.saltController,
                      keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Salz',
                      ),
                    ),
                  ),
                ],),
              ]),
            ),
          ),
        )
      ),
    );
  }
}