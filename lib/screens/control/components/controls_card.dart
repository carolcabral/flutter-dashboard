import 'package:app/constants.dart';
import 'package:app/controllers/mqtt_controller.dart';
import 'package:app/screens/control/components/mode_card.dart';
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

    return _mqttController.connectionStatus == MqttConnectionState.connected
        ? controlButtons()
        : Container();
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
          controlButton("left", const Icon(Icons.arrow_left_rounded)),
          controlButton("idle", const Icon(Icons.stop_circle_rounded)),
          controlButton("right", const Icon(Icons.arrow_right_rounded))
        ],
      ),
    );
  }

  void send_command(String cmd) {
    String id = '1';
    _mqttController.sendCommand("command/robot/$id", cmd);
  }

  Widget controlButton(String cmd, Icon icon) {
    return IconButton(
      onPressed:
          _mqttController.mode == "manual" ? () => send_command(cmd) : null,
      icon: icon,
      iconSize: cmd == "idle" ? 50 : 100,
      disabledColor: Colors.grey.shade400.withOpacity(0.3),
    );
  }
}
