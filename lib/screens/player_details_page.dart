import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/players/players_bloc.dart';
import 'blocs/players/players_repository.dart';
import 'update_player_page.dart';
import '../models/player.dart';
import 'widgets/app_bar/appbar_default.dart';
import 'widgets/layout.dart';

class PlayerDetailsPage extends StatefulWidget {
  final Player player;
  const PlayerDetailsPage({Key? key, required this.player}) : super(key: key);
  @override
  State<StatefulWidget> createState() => PlayerDetailsPageState();

}

class PlayerDetailsPageState extends State<PlayerDetailsPage> {
  final ScrollController _scrollController = ScrollController();
  final _playersRepository = PlayersRepository();
  bool editing = false;

  void changeEdit() {
    setState(() {
      editing = !editing;
    });
  }

  // reason for this function is because the fetch list endpoint does not return
  // all the fields required
  Future<Player> fetchSinglePlayer() async {
    return await _playersRepository.getPlayerById(widget.player.id, widget.player.tournamentId);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchSinglePlayer(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData) {
          Player singlePlayer = snapshot.data;
          return Layout(
              fab: FloatingActionButton(
                child: const Icon(Icons.edit),
                tooltip: 'Add a players to this tournament',
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => UpdatePlayerPage(singlePlayer))
                  );
                },
              ),
              appBar: AppBarDefault(
                title: "Player: ${singlePlayer.firstName} ${singlePlayer.lastName}",
                actions: [
                  IconButton(
                      onPressed: () {
                        context.read<PlayersBloc>().add(
                          DeletePlayer(singlePlayer)
                        );
                      },
                      icon: const Icon(Icons.delete)
                  )
                ],
              ),
              body: BlocListener<PlayersBloc, PlayersState>(
                  listener: (context, state) {
                    if(state is PlayersLoaded) {
                      if(!state.delete) {
                        setState(() {
                          singlePlayer = state.player!;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.snackBarMessage.toString()))
                        );
                        
                        Navigator.of(context).pop();
                      }
                    }
                  },
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      Card(
                        elevation: 5,
                        child: ListTile(
                          contentPadding: const EdgeInsets.only(left: 20, right: 20),
                          title: const Text("ID"),
                          subtitle: Text(singlePlayer.id.toString()),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        child:ListTile(
                          contentPadding: const EdgeInsets.only(left: 20, right: 20),
                          title: const Text("Tournament ID"),
                          subtitle: Text(singlePlayer.tournamentId.toString()),
                        )
                      ),
                      Card(
                        elevation: 5,
                        child:ListTile(
                          contentPadding: const EdgeInsets.only(left: 20, right: 20),
                          title: const Text("First Name"),
                          subtitle: Text(singlePlayer.firstName),
                        )
                      ),
                      Card(
                        elevation: 5,
                        child:ListTile(
                          contentPadding: const EdgeInsets.only(left: 20, right: 20),
                          title: const Text("Last Name"),
                          subtitle: Text(singlePlayer.lastName),
                        )
                      ),
                      Card(
                          elevation: 5,
                          child:ListTile(
                            contentPadding: const EdgeInsets.only(left: 20, right: 20),
                            title: const Text("Description"),
                            subtitle: Text(singlePlayer.description),
                          )
                      ),
                      Card(
                        elevation: 5,
                        child:ListTile(
                          contentPadding: const EdgeInsets.only(left: 20, right: 20),
                          title: const Text("Points"),
                          subtitle: Text(singlePlayer.points.toString()),
                        )
                      ),
                      Card(
                        elevation: 5,
                        child:ListTile(
                          contentPadding: const EdgeInsets.only(left: 20, right: 20),
                          title: const Text("Professional"),
                          subtitle: Text(singlePlayer.isProfessional == 1 ? "Yes" : "No"),
                        )
                      ),
                    ],
                  )
              )
          );
        }
        return Layout(
          body: Container(),
        );
      }
    );
  }
}
