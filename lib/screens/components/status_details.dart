import 'package:app/constants.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../models/Models.dart';
import 'chart.dart';
import 'chart_info_card.dart';

ChartInfo chartInfo =
    ChartInfo(title: "Plants", total: 10, healthy: 6, warning: 3, critical: 1);

class StatusDetails extends StatelessWidget {
  final String title; //Plant / Device

  const StatusDetails({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title Details",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: defaultPadding),
          Chart(
            info: chartInfo,
          ),
          ChartInfoCard(
              title: "Healthy",
              quantity: chartInfo.healthy!,
              percentage: chartInfo.healthy! / chartInfo.total! * 100,
              icon: Icon(Icons.check_circle_rounded, color: Colors.green)),
          ChartInfoCard(
              title: "Warning",
              quantity: chartInfo.warning!,
              percentage: chartInfo.warning! / chartInfo.total! * 100,
              icon: Icon(Icons.warning_rounded, color: Colors.yellow)),
          ChartInfoCard(
              title: "Critical",
              quantity: chartInfo.critical!,
              percentage: chartInfo.critical! / chartInfo.total! * 100,
              icon: Icon(Icons.error, color: Colors.red)),
        ],
      ),
    );
  }
}
