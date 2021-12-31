import 'dart:async';

import 'package:app/constants.dart';
import 'package:app/controllers/MQTTController.dart';
import 'package:app/screens/control/components/controls_card.dart';
import 'package:app/screens/control/components/host_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ControlScreen extends StatelessWidget {
  const ControlScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MQTTController>(
      create: (context) => MQTTController(),
      child: Scaffold(
        appBar: AppBar(
          title:
              Text("MQTT Client" //style: Theme.of(context).textTheme.headline4
                  ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                const Text("MQTT"),
                HostCard(),
                ControlsCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
