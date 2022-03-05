import 'package:flutter/material.dart';
import '../../../screens/tournament_details_page.dart';
import '../../../styles/styles.dart';

class TournamentCard extends StatelessWidget {
  final int tournamentId;


  const TournamentCard({
    Key? key,
    required this.tournamentId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => TournamentDetailsPage(tournamentId: tournamentId))
        );
      },
      child: SizedBox(
        height: 150,
        child: Card(
          elevation: 10,
          child: Center(
            child: Text(
              'Tournament ID: $tournamentId',
              style: Styles.tournamentCardTitle,
            ),
          )
        ),
      ),
    );
  }
}
