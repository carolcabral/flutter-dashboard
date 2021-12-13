import 'package:app/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../models/Models.dart';

class Chart extends StatelessWidget {
  final ChartInfo info;

  const Chart({Key? key, required this.info}) : super(key: key);

  /*
      const PieChartSectionData(color: const Colors.green, value: 10, showTitle: false, radius: 25),
      const PieChartSectionData(color: const Colors.yellow, value: 10, showTitle: false, radius: 25),
      const PieChartSectionData(color: const Colors.red, value: 10, showTitle: false, radius: 25)
  ];*/

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: [
                PieChartSectionData(
                    color: Colors.red,
                    value: info.critical,
                    showTitle: false,
                    radius: 25),
                PieChartSectionData(
                    color: Colors.green,
                    value: info.healthy,
                    showTitle: false,
                    radius: 25),
                PieChartSectionData(
                    color: Colors.yellow,
                    value: info.warning,
                    showTitle: false,
                    radius: 25),
              ],
            ),
          ),
          Positioned.fill(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: defaultPadding),
              Text(
                info.total.toString(),
                style: Theme.of(context).textTheme.headline4?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    height: 0.5),
              ),
              Text("devices"),
            ],
          ))
        ],
      ),
    );
  }
}
