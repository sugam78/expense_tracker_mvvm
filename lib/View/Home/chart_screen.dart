import 'package:expense_tracker_mvvm/ViewModel/Controller/Home/chart_controller.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chartController = ChartController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chart'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(future: chartController.setData(), builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const CircularProgressIndicator();
            }
            else if(snapshot.hasData){
              if(snapshot.data is String){
                return Center(child: Text(snapshot.data,style: const TextStyle(fontSize: 25),));
              }
              return SingleChildScrollView(
                child: PieChart(dataMap: snapshot.data!,
                  animationDuration: const Duration(seconds: 2),
                  legendOptions: const LegendOptions(
                    legendPosition: LegendPosition.bottom,
                  ),
                ),
              );
            }
            return const Text('No data');
          })
        ],
      ),
    );
  }
}
