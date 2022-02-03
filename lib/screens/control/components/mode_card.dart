import 'package:app/constants.dart';
import 'package:app/controllers/mqtt_controller.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:provider/provider.dart';

class ModeCard extends StatefulWidget {
  ModeCard({Key? key}) : super(key: key);

  @override
  State<ModeCard> createState() => _ModeCardState();
}

class _ModeCardState extends State<ModeCard> {
  late MQTTController _mqttController;

  List<bool> isSelected = [true, false];
  List<String> modes = ["automatic", "manual"];

  @override
  Widget build(BuildContext context) {
    _mqttController = Provider.of<MQTTController>(context);

    return _mqttController.connectionStatus == MqttConnectionState.connected
        ? ToggleMode()
        : Container();
  }

  Container ToggleMode() {
    String id = '1';
    return Container(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding),
      alignment: Alignment.center,
      //constraints: const BoxConstraints.tightForFinite(width: 200),
      //color: primaryColor.withOpacity(0.15),
      child: ToggleButtons(
        isSelected: isSelected,
        selectedColor: Colors.lightBlue.shade900,
        color: Colors.white,
        //fillColor: Colors.lightBlue.shade900,
        renderBorder: false,
        //splashColor: Colors.red,
        highlightColor: Colors.orange,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(modes[0], style: const TextStyle(fontSize: 18)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(modes[1], style: const TextStyle(fontSize: 18)),
          ),
        ],
        onPressed: (int newIndex) {
          setState(() {
            for (int index = 0; index < isSelected.length; index++) {
              if (index == newIndex) {
                isSelected[index] = true;
                _mqttController.sendCommand(
                    "command/mode/$id", modes[newIndex]);
                _mqttController.mode = modes[newIndex];
              } else {
                isSelected[index] = false;
              }
            }
            print("MODE: ${_mqttController.mode}");
          });
        },
      ),
    );
  }
}
