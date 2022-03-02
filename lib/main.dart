import 'package:flutter/material.dart';

//screens
import 'screens/home_page.dart';
import 'screens/draw_page.dart';
import 'screens/routing_helpers/tournament_details_page/extract_arguments_tournament_details.dart';

//navigation
import 'services/navigation_service.dart';
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

    /** Using MaterialApp() for this assignment. We could also use
     * CupertinoApp() */
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: locator<NavigationService>().navigatorKey,
      initialRoute: '/',
      routes: {
        '/' : (context) => const HomePage(),
        '/draw-page' : (context) => const DrawPage(),
        '/tournament-details-arguments' : (context) =>
            const ExtractArgumentsTournamentDetails()
      },
    );
  }
}
