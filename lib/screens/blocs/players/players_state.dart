part of 'players_bloc.dart';

abstract class PlayersState extends Equatable {
  const PlayersState();

  @override
  List<Object> get props => [];
}

/// Loading
class PlayersLoading extends PlayersState {
  @override
  List<Object> get props => [];
}

/// Loaded
class PlayersLoaded extends PlayersState {
  final List<Player> players;
  final String? snackBarMessage;
  final Player? player;
  final bool delete;


  const PlayersLoaded({required this.players, this.snackBarMessage, this.player, this.delete = false});

  @override
  List<Object> get props => [players, player ?? false];
}

/// Error
class PlayersError extends PlayersState {

  final String error;


  const PlayersError(this.error);

  @override
  List<Object> get props => [error];
}