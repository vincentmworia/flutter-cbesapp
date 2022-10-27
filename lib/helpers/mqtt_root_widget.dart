import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:provider/provider.dart';

import './mqtt_file.dart';
import './mqtt_provider.dart';
import '../screens/inverter_screen.dart';

enum Status { offline, online, initialization }

// todo connectivity checker all through the app where the connectivity check is required
class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);
  static const routeName = '/main_home';

  static AppBar appBar(GlobalKey<ScaffoldState> scaffoldKey, String title) =>
      AppBar();

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  bool _conn = false;
  var _runLoop = true;

  late MQTTClientWrapper mqttClient;
  late Timer timer;
  MqttServerClient? _client;

  @override
  void initState() {
    super.initState();
    connStatus = Status.initialization;
    mqttClient = MQTTClientWrapper();

    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) async {
      // print('2');
      if (_runLoop) {
        // print('5');
        _runLoop = false;
        if (_client == null) {
          await mqttClient.prepareMqttClient().then((value) {
            _client = value;
          });
        }
        switch (mqttClient.connectionState) {
          case MqttCurrentConnectionState.idle:
            break;
          case MqttCurrentConnectionState.connecting:
            break;
          case MqttCurrentConnectionState.connected:
            if (_conn == false) {
              setState(() {
                _conn = true;
                Provider.of<MqttProvider>(context, listen: false)
                    .setClient(mqttProtocol: mqttClient, client: _client!);
                connStatus = Status.online;
              });
            }
            break;
          case MqttCurrentConnectionState.errorWhenConnecting:
          case MqttCurrentConnectionState.disconnected:
            _client = null;
            setState(() {
              _conn = false;
              Provider.of<MqttProvider>(context, listen: false).resetMqtt();
              connStatus = Status.offline;
            });
            break;
        }
        _runLoop = true;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  late Status connStatus;

  Widget _tempScreen(String title) => SafeArea(
          child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.6),
        appBar: AppBar(
          title: const Text("INVERTER"),
        ),
        body: Center(
          child: Text(
            title,
            style: TextStyle(
                fontSize: 30,
                color: Theme.of(context).colorScheme.primary,
                letterSpacing: 8.0),
          ),
        ),
      ));

  @override
  Widget build(BuildContext context) {
    return connStatus == Status.offline
        ? _tempScreen("OFFLINE")
        : connStatus == Status.online
            ? const InverterScreen()
            : _tempScreen("INITIALIZING");
  }
}
