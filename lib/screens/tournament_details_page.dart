import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:turnir/screens/blocs/tournament_details/tournament_details_bloc.dart';
import 'package:turnir/screens/blocs/tournament_details/tournament_details_repository.dart';
import 'package:turnir/screens/draw_page.dart';
import 'package:turnir/screens/widgets/app_bar/appbar_default.dart';
import 'package:turnir/screens/widgets/layout.dart';
import '../../models/players_model.dart';
import '../screens/widgets/layout.dart';
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
  void initState() {
    super.initState();
    // futurePlayers = fetchPlayersList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TournamentDetailsBloc(
          RepositoryProvider.of<TournamentDetailsRepository>(context),
        )..add(LoadTournamentDetails(widget.tournamentId)),
        child: Layout(
            fab: FloatingActionButton(
              child: const Icon(Icons.add),
              tooltip: 'Add a player to this tournament',
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
            body:BlocBuilder<TournamentDetailsBloc, TournamentDetailsState>(
                builder: (context, state) {
                  if (state is TournamentDetailsLoading) {
                    return const Center(
                        child: CircularProgressIndicator()
                    );
                  }

                  if(state is TournamentDetailsLoaded) {
                    return ListView.separated(
                      separatorBuilder: (context, index) {
                        return const Divider(height: 10);
                      },
                      padding: const EdgeInsets.all(20.0),
                      itemCount: state.players.length,
                      itemBuilder: (context, index) {
                        Players player = state.players[index];
                        return GestureDetector(
                          onTap: () {},
                          child: SizedBox(
                            height: 150,
                            child: Card(
                              elevation: 10,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20, right: 20),
                                child: Column(
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
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return const Text("Something Went Wrong");
                }
            ),
        )
    );
  }
}
