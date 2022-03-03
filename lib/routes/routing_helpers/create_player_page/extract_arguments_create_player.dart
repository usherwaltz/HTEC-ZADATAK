import 'package:flutter/material.dart';
import 'create_player_arguments.dart';
import '../../../screens/create_player_page.dart';

class ExtractArgumentsCreatePlayer extends StatelessWidget {
  const ExtractArgumentsCreatePlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as CreatePlayerArguments;

    return CreatePlayerPage(
      tournamentId: args.tournamentId
    );
  }
}
