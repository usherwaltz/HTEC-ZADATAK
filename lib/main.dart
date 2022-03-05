import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turnir/screens/blocs/tournament_details/tournament_details_bloc.dart';
import 'package:turnir/screens/blocs/tournament_details/tournament_details_repository.dart';
import 'screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {

    /** Using MaterialApp() for this assignment. We could also use
     * CupertinoApp() */
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => TournamentDetailsRepository())
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TournamentDetailsBloc(
              RepositoryProvider.of(context)
            )
          )
        ],
        child: MaterialApp(
            theme: ThemeData(
                primarySwatch: Colors.blue,
                inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder())
            ),
            home: const HomePage()
        ),
      )
    );
  }
}
