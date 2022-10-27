import 'package:flutter/material.dart';

import '../../utilities/inverter_api.dart';

class OperationModeItem extends StatelessWidget {
  const OperationModeItem(this.itemData, {Key? key}) : super(key: key);
  final Map itemData;

  Widget _titleText(BuildContext context, String title) =>
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20.0,
            overflow: TextOverflow.fade,
            color: Theme
                .of(context)
                .colorScheme
                .secondary,
            fontWeight: FontWeight.bold,
            // letterSpacing: 5.0,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final data = itemData[itemData.keys.toList()[0]] as Map;

    final dataToList = [];
    data.forEach((key, value) {
      dataToList.add({key: value});
    });
    // print(dataToList);
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleText(context, decodeKey(itemData.keys.toList()[0])),
          // Container(
          //     height: 300,
          //     // width: double.infinity,
          //     // color: Colors.blue,
          //     child: CustomGridView(dataToList
          //         .map((e) => Card(
          //             child: Text(e.toString())))
          //         .toList()))
          Column(
            children: [
              ...dataToList
                  .map((e) =>
                  Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: SizedBox(
                        width: double.infinity,
                        height: 75,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Text(
                                    decodeKey((e as Map).keys.toList()[0]),
                                    style: TextStyle(
                                        color:
                                        Theme
                                            .of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 18.0,
                                        overflow: TextOverflow.fade),
                                  )),
                              Container(
                                width: 35,
                                height: 35,
                                margin:
                                const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (e).values.toList()[0] == "true"
                                      ? Theme
                                      .of(context)
                                      .colorScheme
                                      .secondary
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )))
                  .toList(),
            ],
          ),
        ],
      ),
    );
  }
}
