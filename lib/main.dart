import 'package:flutter/material.dart';

import './screens/home_screen.dart';
import './screens/inverter_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const appTitle = 'IOT TEMPLATE';
  static const _primaryColor = Color(0xff2B2132);
  static const _secondaryColor = Color(0xffC76546);

  static const _defaultScreen = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: _primaryColor,
          secondary: _secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          toolbarHeight: 65,
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 22.0,
            color: _secondaryColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 5.0,
          ),
        ).copyWith(iconTheme: const IconThemeData(color: _secondaryColor)),
      ),
      home: _defaultScreen,
      routes: {
        InverterScreen.routeName: (_) => const InverterScreen(),
      },
      onGenerateRoute: (settings) => MaterialPageRoute(
        builder: (_) => _defaultScreen,
      ),
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (_) => _defaultScreen,
      ),
    );
  }
}
