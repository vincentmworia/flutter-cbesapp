import 'package:flutter/material.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView(this.children, {Key? key}) : super(key: key);
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView (
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          childAspectRatio: 1 / 1,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 15.0,
          mainAxisExtent: 200,
        ),
        children: children,
      ),
    );
  }
}
