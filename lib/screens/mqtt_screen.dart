import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../constants.dart';

class MQTTScreen extends StatefulWidget {
  const MQTTScreen({Key? key}) : super(key: key);

  @override
  _MQTTScreenState createState() => _MQTTScreenState();
}

class _MQTTScreenState extends State<MQTTScreen> {
  String broker = '192.168.0.10';
  int port = 1883;
  String username = 'user';
  String password = 'password';
  String clientId = 'userId';

  mqtt.MqttClient? client;
  mqtt.MqttConnectionState? connectionStatus;

  StreamSubscription? subscription;

  String topic = 'cmd/1';
  String _command = "idle";

  void _subscribeToTopic(String topic) {
    if (connectionStatus == mqtt.MqttConnectionState.connected) {
      print('[Mqtt client] Subscribing to ${topic.trim()}');
      client?.subscribe(topic, mqtt.MqttQos.exactlyOnce);
    }
  }

  void _connect() async {
    client =
        MqttServerClient(broker, clientId); //MqttServerClient MqttBrowserClient
    client!.port = port;
    client!.logging(on: true);
    client!.keepAlivePeriod = 30;
    client!.onDisconnected = _onDisconnected;

    final mqtt.MqttConnectMessage connMsg = mqtt.MqttConnectMessage()
        .withClientIdentifier(clientId)
        .startClean()
        .withWillQos(mqtt.MqttQos.atMostOnce);
    print('[MQTT client] MQTT client connecting....');
    client!.connectionMessage = connMsg;

    try {
      await client!.connect(username, password);
    } catch (e) {
      print(e);
      _disconnect();
    }

    /// Check if we are connected
    if (client?.connectionStatus!.state == mqtt.MqttConnectionState.connected) {
      //if (client!.connectionStatus == MqttConnectionState.connected) {
      print('[MQTT client] connected');
      setState(() {
        connectionStatus = client!.connectionStatus!.state;
      });
    } else {
      print('[MQTT client] ERROR: MQTT client connection failed - '
          'disconnecting, state is ${client!.connectionStatus}');
      _disconnect();
    }

    /*
    /// The client has a change notifier object(see the Observable class) which we then listen to to get
    /// notifications of published updates to each subscribed topic.
    subscription = client?.updates!.listen(_onMessage);

    _subscribeToTopic("cmd/1");*/
  }

  void _disconnect() {
    print('[MQTT client] _disconnect()');
    client!.disconnect();
    _onDisconnected();
  }

  void _onDisconnected() {
    print('[MQTT client] _onDisconnected');
    setState(() {
      //topics.clear();
      connectionStatus = client?.connectionStatus!.state;
      client = null;
      subscription?.cancel();
      subscription = null;
    });
    print('[MQTT client] MQTT client disconnected');
  }

  void _sendCommand(String cmd) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(cmd);

    /// Check if we are connected
    if (client?.connectionStatus!.state != mqtt.MqttConnectionState.connected) {
      _connect();
    }
    client?.publishMessage(topic, mqtt.MqttQos.atLeastOnce, builder.payload!);
  }

  void _onMessage(List<mqtt.MqttReceivedMessage> event) {
    print(event.length);
    final mqtt.MqttPublishMessage recMess =
        event[0].payload as mqtt.MqttPublishMessage;
    final String message =
        mqtt.MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

    /// The above may seem a little convoluted for users only interested in the
    /// payload, some users however may be interested in the received publish message,
    /// lets not constrain ourselves yet until the package has been in the wild
    /// for a while.
    /// The payload is a byte buffer, this will be specific to the topic
    print('[MQTT client] MQTT message: topic is <${event[0].topic}>, '
        'payload is <-- $message -->');
    print(client!.connectionStatus);
    print("[MQTT client] message with topic: ${event[0].topic}");
    print("[MQTT client] message with message: ${message}");
    setState(() {
      _command = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("MQTT Client" //style: Theme.of(context).textTheme.headline4,
                ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              const Text("MQTT"),
              Container(
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
                      onPressed: () => _sendCommand("left"),
                      icon: Icon(Icons.arrow_left_rounded),
                      iconSize: 100,
                    ),
                    IconButton(
                      onPressed: _connect,
                      icon: Icon(Icons.stop_circle_rounded),
                      iconSize: 50,
                    ),
                    IconButton(
                      onPressed: () => _sendCommand("right"),
                      icon: Icon(Icons.arrow_right_rounded),
                      iconSize: 100,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
