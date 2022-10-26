import 'package:cbesapp/widgets/inverter_screen_items/operation_mode_item.dart';
import 'package:flutter/material.dart';

import '../utilities/inverter_api.dart';
import '../widgets/inverter_screen_items/parameter_item.dart';

class InverterScreen extends StatelessWidget {
  const InverterScreen({Key? key}) : super(key: key);
  static const routeName = "inverter_screen/";

  Widget _titleText(BuildContext context, String title) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 25.0,
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
          _titleText(context, title),
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
                fontSize: 20.0,
                color: Theme.of(context).colorScheme.primary,
              )),
        ],
      );

  @override
  Widget build(BuildContext context) {
    List<Map> mainDataList = [];
    List<Map> operationModeDataList = [];
    late String faultCode;
    late String warningCode;

    useInverterData.forEach((key, value) {
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
    print(operationModeDataList);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("INVERTER"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
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
                  _groupAdditionalInfo(context, "WARNING - $warningCode",
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
