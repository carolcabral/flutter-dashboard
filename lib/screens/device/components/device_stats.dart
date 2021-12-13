import 'package:app/constants.dart';
import 'package:app/models/MyFiles.dart';
import 'package:app/responsive.dart';
import 'package:app/screens/device/components/battery_card.dart';
import 'package:app/screens/device/components/device_state_card.dart';
import 'package:app/screens/device/components/device_status_card.dart';
import 'package:flutter/material.dart';

import '../../../models/Models.dart';

import '../../dashboard/components/favorite_info_card.dart';

class DeviceStats extends StatelessWidget {
  final DeviceInfo info;
  const DeviceStats({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Column(
      children: [
        Text("Device status", style: Theme.of(context).textTheme.subtitle1),
        const SizedBox(height: defaultPadding),
        DeviceStatusCard(stats: info.status),
        const SizedBox(height: defaultPadding),
        DeviceStateCard(state: info.state),
        const SizedBox(height: defaultPadding),
        BatteryCard(status: info.battery_status),

        /*Responsive(
            mobile: DeviceInfoCardGridView(
              crossAxisCount: _size.width < 650 ? 2 : 4,
              childAspectRatio: _size.width < 650 ? 1.3 : 1,
            ),
            tablet: const DeviceInfoCardGridView(),
            desktop: DeviceInfoCardGridView(
              childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
            ))*/
      ],
    );
  }
}
