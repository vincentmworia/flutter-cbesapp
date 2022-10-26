import 'package:cbesapp/utilities/inverter_api.dart';
import 'package:flutter/material.dart';

class InverterScreenItem extends StatelessWidget {
  const InverterScreenItem(this.itemData, {Key? key}) : super(key: key);
  final Map itemData;

  void _navigateScreen(BuildContext context) {
    print(itemData);
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(10.0);
    return GestureDetector(
      onTap: () => _navigateScreen(context),
      onLongPress: () => _navigateScreen(context),
      child: Column(

        children: [

          const Divider(),
          ListTile(
            title: Text(
              decodeKey(itemData.keys.toList()[0].toString()),
              style: TextStyle(
                  fontSize: 20.0,
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis),
            ),
            trailing: Container(
              width: 80,
              height: 80,
              color: Theme.of(context).colorScheme.secondary,
              child: Center(
                child: Text(
                  itemData.values.toList()[0].toString(),
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
