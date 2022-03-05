import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../screens/blocs/tournament_details/tournament_details_repository.dart';
import '../../../models/player.dart';

part 'tournament_details_event.dart';
part 'tournament_details_state.dart';

class TournamentDetailsBloc extends Bloc<TournamentDetailsEvent, TournamentDetailsState> {
  final TournamentDetailsRepository _tournamentDetailsRepository;

  TournamentDetailsBloc(this._tournamentDetailsRepository) : super(TournamentDetailsLoading()) {
    on<LoadTournamentDetails>(_onLoadTournamentDetails);
    on<AddTournamentDetails>(_addTournamentDetails);
  }

  /// On Load
  void _onLoadTournamentDetails(LoadTournamentDetails event, Emitter<TournamentDetailsState> emit) async {
    emit(TournamentDetailsLoading());

    try {
      final players = await _tournamentDetailsRepository.fetchPlayersList(event.tournamentId);
      emit(TournamentDetailsLoaded(players: players));
    } catch (e) {
      emit(TournamentDetailsError(e.toString()));
    }
  }

  /// On Add
  void _addTournamentDetails(AddTournamentDetails event, Emitter<TournamentDetailsState> emit) async {
    final state = this.state;

    try {
      bool playerCreated = await _tournamentDetailsRepository.createPlayer(event.player);

      if(playerCreated && state is TournamentDetailsLoaded) {
        List<Player> players = List.from(state.players)..add(event.player);
        players.sort((b, a) => a.points.compareTo(b.points));
        emit(TournamentDetailsLoaded(
          players: players,
          snackBarMessage: "Successfully created player ${event.player.firstName} ${event.player.lastName}"
        ));
      }
    } catch (e) {
      emit(TournamentDetailsError(e.toString()));
    }
  }
}