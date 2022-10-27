import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/home_screen.dart';
import './helpers/mqtt_provider.dart';
import './screens/inverter_screen.dart';
import './helpers/mqtt_root_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const appTitle = 'CBES IOT';

  // static const _primaryColor = Color(0xff2B2132);
  static const _secondaryColor = Color(0xffC76546);

  //
  static const _primaryColor = Color(0xff1e3d59);

  // static const _secondaryColor = Color(0xff8a307f);

  static const _defaultScreen = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MqttProvider(),
      child: MaterialApp(
        title: appTitle,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: _primaryColor,
            secondary: _secondaryColor,
          ),
          appBarTheme: const AppBarTheme(
            toolbarHeight: 75,
            centerTitle: true,
            elevation: 0,
            color: _primaryColor,
            titleTextStyle: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 5.0,
            ),
          ).copyWith(iconTheme: const IconThemeData(color: Colors.white)),
        ),
        home: _defaultScreen,
        routes: {
          HomeScreen.routeName: (_) => const HomeScreen(),
          InverterScreen.routeName: (_) => const InverterScreen(),
          MainHome.routeName: (_) => const MainHome()
        },
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (_) => _defaultScreen,
        ),
        onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (_) => _defaultScreen,
        ),
      ),
    );
  }
}
