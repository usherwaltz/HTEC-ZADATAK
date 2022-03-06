import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'players_repository.dart';
import '../../../models/player.dart';

part 'players_events.dart';
part 'players_state.dart';

class PlayersBloc extends Bloc<PlayersEvent, PlayersState> {
  final PlayersRepository _playersRepository;

  PlayersBloc(this._playersRepository) : super(PlayersLoading()) {
    on<LoadPlayers>(_onLoadPlayers);
    on<CreatePlayer>(_createPlayer);
    on<UpdatePlayer>(_updatePlayer);
    on<DeletePlayer>(_deletePlayer);
  }

  /// On Load
  void _onLoadPlayers(LoadPlayers event, Emitter<PlayersState> emit) async {
    emit(PlayersLoading());

    try {
      final players = await _playersRepository.fetchPlayersList(event.tournamentId);
      emit(PlayersLoaded(players: players));
    } catch (e) {
      emit(PlayersError(e.toString()));
    }
  }

  /// On Add
  void _createPlayer(CreatePlayer event, Emitter<PlayersState> emit) async {
    final state = this.state;

    try {
      Player playerCreated = await _playersRepository.createPlayer(event.player);

      if(state is PlayersLoaded) {
        List<Player> players = List.from(state.players)..add(playerCreated);
        players.sort((b, a) => a.points.compareTo(b.points));
        emit(PlayersLoaded(
          players: players,
          snackBarMessage: "Successfully created player ${playerCreated.firstName} ${playerCreated.lastName}."
        ));
      }
    } catch (e) {
      emit(PlayersError(e.toString()));
    }
  }

  /// On Update
  void _updatePlayer(UpdatePlayer event, Emitter<PlayersState> emit) async {
    final state = this.state;

    try {
      Player updatedPlayer = await _playersRepository.updatePlayer(event.player);


      if (state is PlayersLoaded) {
        List<Player> players = (state.players.map((player) {
          return player.id == updatedPlayer.id ? updatedPlayer : player;
        })).toList();

        emit(PlayersLoaded(
          players: players,
          snackBarMessage: "Successfully updated player ${updatedPlayer.firstName} ${updatedPlayer.lastName}.",
          player: updatedPlayer
        ));
      }
    } catch (e) {
      emit(PlayersError(e.toString()));
    }

  }

  _deletePlayer(DeletePlayer event, Emitter<PlayersState> emit) async {
    final state = this.state;

    int playerId = await _playersRepository.deletePlayer(event.player);

    if(state is PlayersLoaded) {
      List<Player> players = state.players.where((element) {
        return element.id != playerId;
      }).toList();

      emit(PlayersLoaded(
        players: players,
        delete: true,
        snackBarMessage: "Successfully deleted player."
      ));
    }
  }
}