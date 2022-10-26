import 'package:cbesapp/utilities/inverter_api.dart';
import 'package:cbesapp/widgets/custom_grid_view.dart';
import 'package:cbesapp/widgets/inverter_screen_item.dart';
import 'package:flutter/material.dart';

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
    late String faultCode;
    late String warningCode;

    // inverterDataMain.forEach((key, value) {
    //   if (key == "input_voltage" ||
    //       key == "output_voltage" ||
    //       key == "input_frequency" ||
    //       key == "pv_voltage" ||
    //       key == "pv_current" ||
    //       key == "pv_power" ||
    //       key == "ac_and_pv_charging_current" ||
    //       key == "ac_charging_current" ||
    //       key == "pv_charging_current") {
    //     mainDataList.add({key: value});
    //   }
    //   if (key == "fault_reference_code") {
    //     faultCode = value;
    //   }
    //   if (key == "warning_indicator") {
    //     warningCode = value;
    //   }
    // });

    // print(useInverterData);
    useInverterData.forEach((key, value) {
      if (key == "main_data") {
        (value as Map).forEach((k, val) {
          mainDataList.add({k: val });
        });
      }
    });
    print(mainDataList);
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
                  // _groupAdditionalInfo(
                  //     context, "FAULT - $faultCode", faultReferenceCode(faultCode)),
                  // const Divider(),
                  // _groupAdditionalInfo(
                  //     context, "WARNING - $warningCode", warningIndicator(warningCode)),
                  // const Divider(),
                  // const SizedBox(
                  //   height: 20,
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
