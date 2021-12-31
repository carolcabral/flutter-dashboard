import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MQTTController extends ChangeNotifier {
  //String username = 'user';
  //String password = 'password';

  mqtt.MqttClient? _client;
  mqtt.MqttConnectionState? _connectionStatus;

  String _host = '';

  int _port = 1883;
  String _identifier = 'userId';

  String _topic = 'cmd/1';
  String _command = "idle";

  void initializeMQTTClient(
      {required String host, required String identifier}) {
    _host = host;
    _identifier = identifier;
    _client = MqttServerClient(
        _host, _identifier); //MqttServerClient MqttBrowserClient
    _client!.port = _port;
    _client!.logging(on: true);
    _client!.keepAlivePeriod = 30;
    _client!.onConnected = _onConnected;
    _client!.onDisconnected = _onDisconnected;

    final mqtt.MqttConnectMessage connMsg = mqtt.MqttConnectMessage()
        .withClientIdentifier(_identifier)
        .startClean()
        .withWillQos(mqtt.MqttQos.atMostOnce);
    print('[MQTT client] MQTT client connecting....');
    _client!.connectionMessage = connMsg;
  }

  String? get host => _host;
  mqtt.MqttConnectionState? get connectionStatus => _connectionStatus;

  void connect() async {
    try {
      await _client!.connect('username', 'password');

      print("Connect.........!");
    } catch (e) {
      print(e);
      _disconnect();
    }
  }

  void _disconnect() {
    print('[MQTT client] _disconnect()');
    _client!.disconnect();
  }

  void _onConnected() {
    updateState();
  }

  void _onDisconnected() {
    _connectionStatus = _client?.connectionStatus!.state;
    _client = null;
    updateState();
  }

  void updateState() {
    notifyListeners();
  }

  void sendCommand(String cmd) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(cmd);

    /// Check if we are connected
    if (_client?.connectionStatus!.state !=
        mqtt.MqttConnectionState.connected) {
      connect();
    }
    _client?.publishMessage(_topic, mqtt.MqttQos.atLeastOnce, builder.payload!);
  }
}
