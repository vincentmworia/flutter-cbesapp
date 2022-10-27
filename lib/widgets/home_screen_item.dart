import 'package:flutter/material.dart';

import '../helpers/mqtt_root_widget.dart';
import '../screens/home_screen.dart';
import '../screens/inverter_screen.dart';

class HomeScreenItem extends StatelessWidget {
  const HomeScreenItem({Key? key, required this.title, required this.imageUrl})
      : super(key: key);
  final String title;
  final String imageUrl;

  void _navigateScreen(BuildContext context, String title) {
    switch (title) {
      case HomeScreen.inverter:
        Navigator.pushNamed(context, MainHome.routeName);
        break;
      default:
        // todo CHANGE TO THE DEFAULT PAGE
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(10.0);
    return Column(
      children: [
        Expanded(
          child: Card(
            elevation: 7,
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
            child: GestureDetector(
              onTap: () => _navigateScreen(context, title),
              onLongPress: () => _navigateScreen(context, title),
              child: ClipRRect(
                borderRadius: borderRadius,
                child: Image.asset(
                  "images/$imageUrl",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Theme.of(context).colorScheme.secondary,
          ),
        )
      ],
    );
  }
}
