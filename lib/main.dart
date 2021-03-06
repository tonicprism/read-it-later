import 'package:flutter/material.dart';
import 'package:read_it_later/screens/wrapper.page.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'controllers/theme.controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorHex = 0xFFde2a42;

    FlutterStatusbarcolor.setNavigationBarColor(Color(colorHex));
    FlutterStatusbarcolor.setStatusBarColor(Color(colorHex));

    Map<int, Color> color = {
      50: Color.fromRGBO(222, 42, 66, 1),
      100: Color.fromRGBO(222, 42, 66, 2),
      200: Color.fromRGBO(222, 42, 66, 3),
      300: Color.fromRGBO(222, 42, 66, 4),
      400: Color.fromRGBO(222, 42, 66, 5),
      500: Color.fromRGBO(222, 42, 66, 6),
      600: Color.fromRGBO(222, 42, 66, 7),
      700: Color.fromRGBO(222, 42, 66, 8),
      800: Color.fromRGBO(222, 42, 66, 9),
      900: Color.fromRGBO(222, 42, 66, 10),
    };
    MaterialColor colorCustom = MaterialColor(colorHex, color);
    
    return AnimatedBuilder(
        animation: ThemeController.instance,
        builder: (context, child) {
          return MaterialApp(
            title: 'Read It Latter',
            theme: ThemeData(
              primarySwatch: colorCustom,
            ),
            darkTheme: ThemeData(
                brightness: Brightness.dark,
                primarySwatch: colorCustom,
                accentColor: Color(colorHex),
                accentTextTheme:
                    TextTheme(bodyText1: TextStyle(color: Colors.white38,))
                ),
            themeMode: ThemeController.instance.getIsDark()
                ? ThemeMode.dark
                : ThemeMode.light,
            home: DefaultTabController(length: 3, child: Wrapper()),
          );
        });
  }
}
