import 'package:cbesapp/main.dart';
import 'package:flutter/material.dart';

import '../widgets/home_screen_item.dart';
import '../widgets/custom_grid_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = "home_screen/";
  static const inverter = "Inverter";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(MyApp.appTitle),
        ),
        body: const CustomGridView([
          HomeScreenItem(title: inverter, imageUrl: "inverter_image.jpg"),
        ]),
      ),
    );
  }
}
