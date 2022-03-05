import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turnir/screens/blocs/tournament_details/tournament_details_repository.dart';
import '../../../models/players_model.dart';

part 'tournament_details_event.dart';
part 'tournament_details_state.dart';

class TournamentDetailsBloc extends Bloc<TournamentDetailsEvent, TournamentDetailsState> {
  final TournamentDetailsRepository _tournamentDetailsRepository;

  TournamentDetailsBloc(this._tournamentDetailsRepository) : super(TournamentDetailsLoading()) {
    on<LoadTournamentDetails>((event, emit) async {
      emit(TournamentDetailsLoading());

      try {
        final players = await _tournamentDetailsRepository.fetchPlayersList(event.tournamentId);
        emit(TournamentDetailsLoaded(players: players));
      } catch (e) {
        emit(TournamentDetailsError(e.toString()));
      }
    });

    on<AddTournamentDetails>((event, emit) async {
      final state = this.state;
      if(state is TournamentDetailsLoaded) {
        emit(TournamentDetailsLoaded(
          players: List.from(state.players)..add(event.player)
        ));
      }
    });
  }
}