import 'package:flutter/material.dart';
import 'tournament_details_arguments.dart';
import '../../../screens/tournament_details_page.dart';

class ExtractArgumentsTournamentDetails extends StatelessWidget {
  const ExtractArgumentsTournamentDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as TournamentDetailsArguments;

    return TournamentDetailsPage(
      tournamentId: args.tournamentId,
    );
  }
}
