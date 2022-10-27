import 'package:flutter/material.dart';

import '../../utilities/inverter_api.dart';

class InverterScreenItem extends StatelessWidget {
  const InverterScreenItem(this.itemData, {Key? key}) : super(key: key);
  final Map itemData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        ListTile(
          title: Text(
            decodeKey(itemData.keys.toList()[0].toString()),
            style: TextStyle(
                fontSize: 18.0,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis),
          ),
          trailing: Container(
            width: 80,
            height: 80,
            margin: const EdgeInsets.only(left: 5),
            child: Center(
              child: Text(
                itemData.values.toList()[0].toString(),
                style:  TextStyle(
                  fontSize: 20.0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
