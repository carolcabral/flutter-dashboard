import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MQTTController extends ChangeNotifier {
  //String username = 'user';
  //String password = 'password';

  mqtt.MqttClient? _client;
  mqtt.MqttConnectionState? get connectionStatus =>
      _client?.connectionStatus!.state;

  String _host = '';
  String? get host => _host;

  late String _mode = 'automatic';
  String get mode => _mode;
  set mode(String value) {
    _mode = value;
    updateState();
  }

  late String _cleaner_state = 'on'; //cleanerState
  String get cleaner_state => _cleaner_state;
  set cleaner_state(String stat) {
    _cleaner_state = stat;
    updateState();
  }



  final int _port = 1883;
  String _identifier = 'userId';

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

  void connect() async {
    try {
      await _client!.connect('username', 'password');
    } catch (e) {
      print(e);
      disconnect();
    }
  }

  void disconnect() {
    print('[MQTT client] _disconnect()');
    _client!.disconnect();
  }

  void _onConnected() {
    print("Connected.........!");
    print("State on connected is:");
    print(connectionStatus);

    updateState();
  }

  void _onDisconnected() {
    //_state = _client?.connectionStatus!.state;
    _client = null;
    updateState();
  }

  void updateState() {
    notifyListeners();
  }

  void sendCommand(String topic, int id, String cmd) {
    String msg = '{ "id" : "${id}", "msg": "${cmd}"}';

    final builder = MqttClientPayloadBuilder();
    builder.addString(msg);

    /// Check if we are connected
    if (_client?.connectionStatus!.state !=
        mqtt.MqttConnectionState.connected) {
      connect();
    }
    _client?.publishMessage(topic, mqtt.MqttQos.atLeastOnce, builder.payload!);
  }
}
