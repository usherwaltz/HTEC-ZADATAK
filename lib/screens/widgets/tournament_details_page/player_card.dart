import 'package:flutter/material.dart';
import '../../../models/player.dart';
import '../../player_details_page.dart';

class PlayerCard extends StatelessWidget {
  final Player player ;
  const PlayerCard({
    Key? key,
    required this.player
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "${player.firstName} ${player.lastName}",
                    style: const TextStyle(
                        fontSize: 20
                    ),
                  ),
                  Text(
                      'Points: ${player.points}'
                  ),
                  Text(
                      player.isProfessional == 1 ?
                      "Professional: Yes" :
                      "Professional: No"
                  ),
                  if(player.tournamentId != null)
                    Text("Tournament ID: ${player.tournamentId}")
                ],
              ),
              if(player.tournamentId != null)
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return PlayerDetailsPage(player: player);
                      })
                    );
                  },
                  icon: const Icon(
                    Icons.remove_red_eye,
                    color: Colors.blue,
                    size: 30,
                  )
                )
            ],
          ),
        ),
      ),
    );
  }
}
