part of 'players_bloc.dart';

abstract class PlayersEvent extends Equatable {
  const PlayersEvent();
}

class LoadPlayers extends PlayersEvent {
  final int tournamentId;

  const LoadPlayers(this.tournamentId);

  @override
  List<Object> get props => [tournamentId];
}

class CreatePlayer extends PlayersEvent {
  final Player player;

  const CreatePlayer(this.player);

  @override
  List<Object> get props => [player];

}

class UpdatePlayer extends PlayersEvent {
  final Player player;

  const UpdatePlayer(this.player);

  @override
  List<Object> get props => [player];
}

class DeletePlayer extends PlayersEvent {
  final Player player;
  const DeletePlayer(this.player);

  @override
  List<Object> get props => [player];
}