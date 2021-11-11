import 'package:app/constants.dart';
import 'package:app/models/RecentFile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../models/Models.dart';
import '../../responsive.dart';
import '../components/chart_info_card.dart';
import '../device/components/device_stats.dart';
import '../components/header.dart';
import 'components/favorites.dart';
import 'components/plants_info_card.dart';
import '../components/status_details.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      if (Responsive.isMobile(context))
                        StatusDetails(title: "Overall "),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      Favorites(),
                      SizedBox(height: defaultPadding),

                      Column(
                        children: [
                          Text("My Plants",
                              style: Theme.of(context).textTheme.subtitle1),
                          const SizedBox(height: defaultPadding),
                          PlantsInfoCard(info: userPlants[0]),
                          PlantsInfoCard(info: userPlants[1]),
                          PlantsInfoCard(info: userPlants[2]),
                        ],
                      ),

                      // DeviceStats(),

                      //RecentFiles(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: StatusDetails(title: "Plants"),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
