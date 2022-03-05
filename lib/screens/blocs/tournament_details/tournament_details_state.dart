part of 'tournament_details_bloc.dart';

abstract class TournamentDetailsState extends Equatable {
  const TournamentDetailsState();

  @override
  List<Object> get props => [];
}

/// Loading
class TournamentDetailsLoading extends TournamentDetailsState {
  @override
  List<Object> get props => [];
}

/// Loaded
class TournamentDetailsLoaded extends TournamentDetailsState {
  final List<Player> players;
  final String? snackBarMessage;


  const TournamentDetailsLoaded({required this.players, this.snackBarMessage});

  @override
  List<Object> get props => [players];
}

/// Error
class TournamentDetailsError extends TournamentDetailsState {

  final String error;


  const TournamentDetailsError(this.error);

  @override
  List<Object> get props => [error];
}