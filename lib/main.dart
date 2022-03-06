import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/blocs/players/players_bloc.dart';
import 'screens/blocs/players/players_repository.dart';
import 'screens/home_page.dart';

void main() async {
  await Future.delayed(const Duration(seconds: 1));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);

    /** Using MaterialApp() for this assignment. We could also use
     * CupertinoApp() */
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => PlayersRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PlayersBloc(
              RepositoryProvider.of(context)
            )
          ),
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
