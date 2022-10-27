import 'dart:async';

import 'package:cbesapp/screens/home_screen.dart';
import 'package:cbesapp/widgets/inverter_screen_items/operation_mode_item.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import '../helpers/mqtt_provider.dart';
import '../utilities/inverter_api.dart';
import '../widgets/inverter_screen_items/parameter_item.dart';

class InverterScreen extends StatefulWidget {
  const InverterScreen({Key? key}) : super(key: key);
  static const routeName = "/inverter_screen";

  @override
  State<InverterScreen> createState() => _InverterScreenState();
}

class _InverterScreenState extends State<InverterScreen> {
  StreamController pyStreamData = StreamController();
  var pyInverterData = {
    "main_data": {
      "input_voltage": "23V",
      "output_voltage": "34V",
      "input_frequency": "0Hz",
      "pv_voltage": "0V",
      "pv_current": "0A",
      "pv_power": "0W",
      "ac_and_pv_charging_current": "0A",
      "ac_charging_current": "0A",
      "pv_charging_current": "0A"
    },
    "fault_reference_code": "f02",
    "warning_indicator": "06",
    "operation_modes": {
      "standby_mode": {
        "charging_by_utility_and_pv_energy": "false",
        "charging_by_utility": "false",
        "charging_by_pv_energy": "false",
        "no_charging": "false"
      },
      "fault_mode": {
        "charging_by_utility_and_pv_energy": "false",
        "charging_by_utility": "false",
        "charging_by_pv_energy": "false",
        "no_charging": "false"
      },
      "line_mode": {
        "charging_by_utility_and_pv_energy": "false",
        "charging_by_utility": "false",
        "solar_energy_not_sufficient": "false",
        "battery_not_connected": "false",
        "power_from_utility": "false"
      },
      "battery_mode": {
        "power_from_battery_and_pv_energy": "false",
        "pv_energy_to_loads_and_charge_battery_no_utility": "false",
        "power_from_battery": "false",
        "power_from_pv_energy": "false"
      }
    }
  };
  late MqttServerClient client;

  @override
  void initState() {
    super.initState();
    client = Provider.of<MqttProvider>(context, listen: false).client;
    client.subscribe('inverter_data', MqttQos.atMostOnce);
    client.subscribe('server_status', MqttQos.atMostOnce);
    client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
      final message =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      if (c[0].topic == 'inverter_data') {
        pyStreamData.sink.add(message);
      }
      if (c[0].topic == 'server_status') {
        loaded = false;
        print(message);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    pyStreamData.close();
    client.disconnect();
  }

  Widget _titleText(BuildContext context, String title) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20.0,
            overflow: TextOverflow.fade,
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold,
            letterSpacing: 5.0,
          ),
        ),
      );

  Widget _groupParameters(BuildContext context, String title, List list) =>
      Column(
        children: [
          ...(list.map((e) => InverterScreenItem(e as Map)).toList()),
          const Divider(),
        ],
      );

  Widget _groupAdditionalInfo(
          BuildContext context, String title, String code) =>
      Column(
        children: [
          _titleText(context, title),
          Text(code,
              style: TextStyle(
                fontSize: 18.0,
                color: Theme.of(context).colorScheme.primary,
              )),
        ],
      );
  var loaded = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("INVERTER"),
        ),
        body: StreamBuilder(
            stream: pyStreamData.stream,
            builder: (context, snapshot) {
              List<Map> mainDataList = [];
              List<Map> operationModeDataList = [];
              late String faultCode;
              late String warningCode;

              Timer.periodic(const Duration(seconds: 5), (timer) async {
                if (!loaded) {
                  print("object");
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: const Center(
                              child: Text(
                                "Inverter Offline",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Center(
                                    child: Text(
                                      "OK",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ))
                            ],
                          )).then((value) => Navigator.pop(context));
                  loaded = true;
                }
              });
              if (snapshot.connectionState == ConnectionState.waiting) {
                Provider.of<MqttProvider>(context, listen: false)
                    .mqttProtocol
                    .publishMessage('flutter_request_data', 'initialize');
                return const Center(child: CircularProgressIndicator());
              }

              loaded = true;

              (json.decode(snapshot.data) as Map).forEach((key, value) {
                if (key == "main_data") {
                  (value as Map).forEach((k, val) {
                    mainDataList.add({k: val});
                  });
                }
                if (key == "fault_reference_code") {
                  faultCode = value as String;
                }
                if (key == "warning_indicator") {
                  warningCode = value as String;
                }
                if (key == "operation_modes") {
                  (value as Map).forEach((k, val) {
                    operationModeDataList.add({k: val});
                  });
                }
              });

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top,
                  child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          _groupParameters(context, "PARAMETERS", mainDataList),
                          _groupAdditionalInfo(context, "FAULT - $faultCode",
                              faultReferenceCode(faultCode)),
                          const Divider(),
                          _groupAdditionalInfo(
                              context,
                              "WARNING - $warningCode",
                              warningIndicator(warningCode)),
                          const Divider(),
                          _titleText(context, "OPERATION MODES"),
                          ...operationModeDataList
                              .map((e) => OperationModeItem(e))
                              .toList(),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      )),
                ),
              );
            }),
      ),
    );
  }
}
