import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<SampleData> chartData;

  @override
  void initState() {
    chartData = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: SizedBox(
                height: 350,
                child: SfCartesianChart(
                  primaryYAxis: NumericAxis(interval: 10),
                  primaryXAxis:
                      NumericAxis(interval: 2, minimum: 0, maximum: 11),
                  series: <ChartSeries<SampleData, num>>[
                    ScatterSeries(
                        markerSettings:
                            const MarkerSettings(width: 5, height: 5),
                        dataSource: chartData,
                        xValueMapper: (SampleData data, _) => data.x,
                        yValueMapper: (SampleData data, _) => data.y)
                  ],
                ))));
  }

  List<SampleData> getData() {
    final List<SampleData> data = [];
    for (int i = 1; i <= 10; i++) {
      for (int j = 0; j < 25; j++) {
        //Formula to find the jitter values
        final double jitterValue = (Random().nextDouble() - 0.5) * 0.3;
        data.add(SampleData(
            i + jitterValue, getRandomData(1, 40) + Random().nextDouble()));
      }
    }
    return data;
  }

  int getRandomData(int min, int max) {
    return min + Random().nextInt(max - min);
  }
}

class SampleData {
  SampleData(this.x, this.y);
  final num x;
  final num y;
}
