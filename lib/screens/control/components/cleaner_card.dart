import 'package:app/constants.dart';
import 'package:app/controllers/mqtt_controller.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:provider/provider.dart';

class CleanerCard extends StatefulWidget {
  CleanerCard({Key? key}) : super(key: key);

  @override
  State<CleanerCard> createState() => _CleanerCardState();
}

class _CleanerCardState extends State<CleanerCard> {
  late MQTTController _mqttController;

  @override
  Widget build(BuildContext context) {
    _mqttController = Provider.of<MQTTController>(context);

    return _mqttController.connectionStatus == MqttConnectionState.connected
        ? ToggleCard()
        : Container();
  }

  Widget ToggleCard() {
    return Container(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.cleaning_services_rounded),
        label: Text("Cleaner ${_mqttController.cleaner_state}"),
        style: ElevatedButton.styleFrom(
          primary: _mqttController.cleaner_state == "on"
              ? primaryColor
              : Colors.grey.shade400.withOpacity(0.3),
        ),
        onPressed: () {
          toggleCleaner();
        },
      ),
    );
  }

  void toggleCleaner() {
    String id = '1';
    String cmd = _mqttController.cleaner_state == "on" ? "off" : "on";

    _mqttController.sendCommand("command/cleaner/$id", cmd);
    _mqttController.cleaner_state = cmd;
  }
}
