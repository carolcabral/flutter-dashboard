import 'package:app/constants.dart';
import 'package:app/controllers/MQTTController.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:provider/provider.dart';

class ControlsCard extends StatefulWidget {
  const ControlsCard({Key? key}) : super(key: key);

  @override
  _ControlsCardState createState() => _ControlsCardState();
}

class _ControlsCardState extends State<ControlsCard> {
  late MQTTController _mqttController;

  @override
  void dispose() {
    _mqttController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _mqttController = Provider.of<MQTTController>(context);

    return controlButtons();
  }

  Widget controlButtons() {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => _mqttController.sendCommand("left"),
            icon: const Icon(Icons.arrow_left_rounded),
            iconSize: 100,
          ),
          IconButton(
            onPressed: () => _mqttController.sendCommand("idle"),
            icon: const Icon(Icons.stop_circle_rounded),
            iconSize: 50,
          ),
          IconButton(
            onPressed: () => _mqttController.sendCommand("right"),
            icon: const Icon(Icons.arrow_right_rounded),
            iconSize: 100,
          )
        ],
      ),
    );
  }
}
