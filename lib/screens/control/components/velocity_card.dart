import 'package:app/constants.dart';
import 'package:app/controllers/mqtt_controller.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:provider/provider.dart';

class VelocityCard extends StatefulWidget {
  VelocityCard({Key? key}) : super(key: key);

  @override
  State<VelocityCard> createState() => _VelocityCardState();
}

class _VelocityCardState extends State<VelocityCard> {
  late MQTTController _mqttController;

  double _currentSliderValue = 20;

  String id = '1';

  Widget build(BuildContext context) {
    _mqttController = Provider.of<MQTTController>(context);

    return _mqttController.connectionStatus == MqttConnectionState.connected
        ? Slider(
      value: _currentSliderValue,
      max: 100,
      divisions: 10,
      label: _currentSliderValue.round().toString(),
      onChanged: (double value) {
        setState(() {
          _currentSliderValue = value;
          _mqttController.sendCommand(
              "command/velocity/$id", _currentSliderValue.toString());
        });
      },
    ) : Container();
  }
}
