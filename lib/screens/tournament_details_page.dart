import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'widgets/tournament_details_page/player_card.dart';
import 'blocs/players/players_bloc.dart';
import '../screens/draw_page.dart';
import '../screens/widgets/app_bar/appbar_default.dart';
import '../screens/widgets/layout.dart';
import '../../models/player.dart';
import 'create_player_page.dart';

class TournamentDetailsPage extends StatefulWidget {
  final int tournamentId;

  const TournamentDetailsPage({
    Key? key,
    required this.tournamentId
  }) : super(key: key);

  @override
  State<TournamentDetailsPage> createState() => _TournamentDetailsPageState();
}

class _TournamentDetailsPageState extends State<TournamentDetailsPage> {

  @override
  Widget build(BuildContext context) {

    final PlayersBloc _playersBloc =
      BlocProvider.of<PlayersBloc>(context)
      ..add(LoadPlayers(widget.tournamentId));

    return Layout(
      fab: FloatingActionButton(
        child: const Icon(Icons.add),
        tooltip: 'Add a players to this tournament',
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CreatePlayerPage(tournamentId: widget.tournamentId))
          );
        },
      ),
      appBar: AppBarDefault(
        title: "Tournament ID: ${widget.tournamentId}",
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const DrawPage())
                );
              },
              icon: const Icon(
                Icons.account_tree,
                color: Colors.white,
              )
          ),
        ],
      ),
      body:BlocBuilder<PlayersBloc, PlayersState>(
          bloc: _playersBloc,
          builder: (context, state) {
            if (state is PlayersLoading) {
              return const Center(
                  child: CircularProgressIndicator()
              );
            }

            if(state is PlayersLoaded) {

              return Column(
                children: [
                  const SizedBox(
                    height: 50,
                    child: Center(
                      child: Text(
                        "Players List",
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const Divider(height: 10);
                        },
                        padding: const EdgeInsets.all(20.0),
                        itemCount: state.players.length,
                        itemBuilder: (context, index) {
                          Player player = state.players[index];
                          return PlayerCard(player: player);
                        },
                      )
                  )
                ],
              );
            }

            return const Text("Something Went Wrong");
          }
      ),
    );
  }
}
