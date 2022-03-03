import 'package:flutter/material.dart';
import '../../screens/routing_helpers/tournament_details_page/tournament_details_arguments.dart';
import '../../helper_classes/styles.dart';
import '../../locator.dart';
import '../../services/navigation_service.dart';

class TournamentCard extends StatelessWidget {
  final int tournamentId;
  final NavigationService _navigationService =  locator<NavigationService>();


  TournamentCard({
    Key? key,
    required this.tournamentId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _navigationService.navigateTo(
            '/tournament-details-arguments',
            TournamentDetailsArguments(tournamentId)
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
