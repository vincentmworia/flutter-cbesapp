import 'package:flutter/material.dart';

import '../widgets/home_screen_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = "home_screen/";
  static const inverter = "Inverter";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title:const Text("CBES PROJECT"),),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView(
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              childAspectRatio: 1 / 1,
              crossAxisSpacing: 15.0,
              mainAxisSpacing: 15.0,
              mainAxisExtent: 200,
            ),
            children: const [
              HomeScreenItem(title: inverter,imageUrl: "inverter_image.jpg"),
            ],
          ),
        ),
      ),
    );
  }
}
