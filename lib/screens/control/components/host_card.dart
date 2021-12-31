import 'package:app/controllers/MQTTController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class HostCard extends StatefulWidget {
  const HostCard({
    Key? key,
  }) : super(key: key);

  @override
  State<HostCard> createState() => _HostCardState();
}

class _HostCardState extends State<HostCard> {
  final inputController = TextEditingController();
  late MQTTController _mqttController;

  @override
  void dispose() {
    _mqttController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _mqttController = Provider.of<MQTTController>(context);

    return Container(
      margin: const EdgeInsets.only(top: defaultPadding),
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultPadding),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: inputController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  hintText: "MQTT host"),
            ),
          ),
          _mqttController.connectionStatus == MqttConnectionState.connected
              ? IconButton(onPressed: () {}, icon: const Icon(Icons.close))
              : IconButton(
                  onPressed: _configureAndConnect,
                  icon: const Icon(Icons.play_arrow)),
        ],
      ),
    );
  }

  void _configureAndConnect() async {
    _mqttController.initializeMQTTClient(
        host: inputController.text, identifier: "FlutterApp");
    _mqttController.connect();
  }
}
