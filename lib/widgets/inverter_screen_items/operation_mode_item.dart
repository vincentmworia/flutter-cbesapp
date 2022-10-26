import 'package:flutter/material.dart';

class OperationModeItem extends StatelessWidget {
  const OperationModeItem(this.itemData, {Key? key}) : super(key: key);
  final Map itemData;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        height: 200,
        color: Colors.red,
        child: Text(itemData.toString()),
      ),
    );
  }
}
