part of 'tournament_details_bloc.dart';

abstract class TournamentDetailsEvent extends Equatable {
  const TournamentDetailsEvent();
}

class LoadTournamentDetails extends TournamentDetailsEvent {
  final int tournamentId;

  const LoadTournamentDetails(this.tournamentId);

  @override
  List<Object> get props => [tournamentId];
}

class AddTournamentDetails extends TournamentDetailsEvent {
  final Players player;

  const AddTournamentDetails(this.player);

  @override
  List<Object> get props => [player];

}