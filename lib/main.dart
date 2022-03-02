import 'package:flutter/material.dart';
import 'package:turnir/screens/draw_page.dart';
import 'services/navigation_service.dart';
import 'screens/home_page.dart';
import 'locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: locator<NavigationService>().navigatorKey,
      initialRoute: '/',
      routes: {
        '/' : (context) => const HomePage(),
        '/draw-page' : (context) => const DrawPage()
      },
    );
  }
}
