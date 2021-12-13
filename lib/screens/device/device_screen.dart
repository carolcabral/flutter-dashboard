import 'package:app/constants.dart';
import 'package:app/models/Models.dart';
import 'package:app/screens/components/status_details.dart';
import 'package:flutter/material.dart';

import 'components/device_stats.dart';

class DevicePage extends StatelessWidget {
  final DeviceInfo info;

  const DevicePage({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          info.name,
          //style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(children: [DeviceStats(info: info)]),
        ),
      ),
    );
  }
}
