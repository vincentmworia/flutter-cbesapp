import 'package:flutter/material.dart';

class OperationModeItem extends StatelessWidget {
  const OperationModeItem(this.itemData, {Key? key}) : super(key: key);
  final Map itemData;

  @override
  Widget build(BuildContext context) {
    // TODO USE CARDS IN GRID VIEW???
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: 200,
        // color: Colors.red,
        child: Center(child: Text(itemData.toString())),
      ),
    );
  }
}
