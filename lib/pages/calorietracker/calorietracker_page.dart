import 'package:calpal2/backend/sqlite.dart';
import 'package:calpal2/pages/calorietracker/add_product/add_product_page.dart';
import 'package:calpal2/pages/calorietracker/calorietracker_page_bloc.dart';
import 'package:calpal2/pages/calorietracker/edit_product/edit_product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CalorieTrackerPage extends StatelessWidget {
  const CalorieTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SQLiteDatabase.getProducts(DateFormat('yyyy-MM-dd').format(DateTime.now())),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const CalorieTrackerPageContent();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },);
  }
}

class CalorieTrackerPageContent extends StatelessWidget {
  const CalorieTrackerPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CalorieTrackerPageBloc(),
        child: Consumer<CalorieTrackerPageBloc>(builder: (context, bloc, child) => 
        Column(children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      Text('${bloc.userData.name != "" ? "Hallo ${bloc.userData.name}" : "Hallo Fremder"}!', style: const TextStyle(fontSize: 18)),
                      SfCircularChart(
                        title: ChartTitle(
                          text: 'Kalorienverbrauch',
                          alignment: ChartAlignment.near,
                          textStyle: const TextStyle(fontSize: 12),
                        ),
                        tooltipBehavior: TooltipBehavior(enable: false),
                        series: [
                          DoughnutSeries<ChartData, String>(
                            dataSource: bloc.calorieData,
                            xValueMapper: (data, _) => data.x,
                            yValueMapper: (data, _) => data.y,
                            radius: '100%',
                            innerRadius: '0%',
                            pointColorMapper: (data, _) => data.x == 'Left' ? Colors.grey : const Color(0xFF253C78),
                            dataLabelMapper: (data, _) => data.x == 'Left' ? '${data.y.round()} kcal' : '${data.y.round()} kcal',
                            dataLabelSettings: const DataLabelSettings(
                              isVisible: true,
                              labelPosition: ChartDataLabelPosition.outside,
                              textStyle: TextStyle(
                                color: Colors.black87,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 15),
                          const Icon(Icons.info, color: Color(0xFF253C78)),
                          const SizedBox(width: 5),
                          Text('Dein Kalorienziel beträgt ${bloc.userData.goalCalories} kcal.'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 15),
                          Icon(Icons.circle, color: Color(0xFF253C78)),
                          SizedBox(width: 5),
                          Text('= Verbraucht'),
                          SizedBox(width: 15),
                          Icon(Icons.circle, color: Colors.grey),
                          SizedBox(width: 5),
                          Text('= Übrig'),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(
                        width: 200,
                        child: Divider()
                      ),
                      const SizedBox(height: 10),
                      Column(children: [
                        Text(bloc.products.length > 0 ? 'Heute gegessene Produkte:' : 'Noch keine Produkte gegessen'),
                        const SizedBox(height: 10),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: bloc.products.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              tileColor: index % 2 == 1 ? Colors.grey[100] : Colors.white,
                              leading: SizedBox(
                                width: 40,
                                child: Image.network(bloc.products[index]['image'])),
                              title: Text(bloc.products[index]['brand'] + ' ' + bloc.products[index]['name']),
                              subtitle: Text('${bloc.products[index]['calories']} kcal'),
                              trailing: Wrap(
                                spacing: 12,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditProductPage(tabKey: bloc.products[index]['id'])));
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () async {
                                      final result = await showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text('Produkt löschen'),
                                          content: const Text('Möchtest du das Produkt wirklich löschen?'),
                                          actions: [
                                            TextButton(
                                              child: const Text('Abbrechen'),
                                              onPressed: () => Navigator.pop(context, false),
                                            ),
                                            TextButton(
                                              child: const Text('Löschen'),
                                              onPressed: () => Navigator.pop(context, true),
                                            ),
                                          ],
                                        ),
                                      );
                                      if (result) {
                                        SQLiteDatabase.deleteProduct(bloc.products[index]['id']);
                                        bloc.updateProducts();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],)
                    ],
                    
                  ),
                ],
              ),
            ),
          ),
          Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          controller: bloc.searchController,
                          keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          decoration: const InputDecoration(
                            hintText: 'Barcode eingeben..',
                            border: OutlineInputBorder(),
                      
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      height: 50,
                      child: bloc.searchController.text == "" ?
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const AddProductPage(tabKey: '')));
                          },
                        ) :
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            bloc.searchProduct(context);
                          },
                        ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      height: 50,
                      child: IconButton(
                        icon: const Icon(Icons.camera_enhance),
                        onPressed: () {
                          bloc.scanBarcode(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
        ],),
      ),
      );
  }
}