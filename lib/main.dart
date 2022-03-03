import 'package:flutter/material.dart';

//screens
import 'screens/home_page.dart';
import 'screens/draw_page.dart';
import 'routes/routing_helpers/tournament_details_page/extract_arguments_tournament_details.dart';
import 'routes/routing_helpers/create_player_page/extract_arguments_create_player.dart';

//navigation
import 'routes/routes.dart';
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
        Routes.home              : (context) => const HomePage(),
        Routes.brackets          : (context) => const DrawPage(),
        Routes.tournamentDetails : (context) => const ExtractArgumentsTournamentDetails(),
        Routes.createPlayer      : (context) => const ExtractArgumentsCreatePlayer()
      },
    );
  }
}
