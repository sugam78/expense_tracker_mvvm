import 'package:expense_tracker_mvvm/ViewModel/Controller/Home/chart_controller.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../Core/Constants/app_constants.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chartController = ChartController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
                future: chartController.setData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    if (snapshot.data is String) {
                      return Center(
                          child: Text(
                        snapshot.data,
                        style: TextStyle(
                          fontSize: mq.height * 0.035,
                        ),
                      ));
                    }
                    return SingleChildScrollView(
                      child: PieChart(
                        dataMap: snapshot.data!,
                        animationDuration: const Duration(seconds: 2),
                        legendOptions: LegendOptions(
                            legendShape: BoxShape.rectangle,
                            legendPosition: LegendPosition.bottom,
                            legendTextStyle:
                                TextStyle(fontSize: mq.height * 0.015)),
                      ),
                    );
                  }
                  return const Text('No data');
                })
          ],
        ),
      ),
    );
  }
}
