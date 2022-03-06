import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import '../../../models/player.dart';
import '../repository_helpers/players_repository/players_repository_helper.dart';

class PlayersRepository {
  final String _baseUrl = 'http://internships-mobile.htec.co.rs/api/players';

  Future<List<Player>> fetchPlayersList(int tournamentId) async {
    final response = await http.get(Uri.parse(_baseUrl), headers: {"x-tournament-id":"$tournamentId"});

    if(response.statusCode == 200) {
      var parsed = jsonDecode(response.body)['data'];

      List<Player> players = convertToPlayerModel(parsed);
      players.sort((b, a) => a.points.compareTo(b.points));
      return players;
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<Player> createPlayer(Player player) async {

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'accept': 'application/json',
          'x-tournament-id': "${player.tournamentId}",
          'content-type': 'application/json'
        },
        body: jsonEncode(player),
      );

      if(response.statusCode == 200) {
        return Player.fromJson(jsonDecode(response.body)['data']);
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Player> updatePlayer(Player player) async {
    final url = _baseUrl + "/${player.id}";

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'accept': 'application/json',
          'x-tournament-id': "${player.tournamentId}",
          'content-type': 'application/json'
        },
        body: jsonEncode(player),
      );

      if(jsonDecode(response.body)['success']) {
        return Player.fromJson(jsonDecode(response.body)['data']);
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<int> deletePlayer(Player player) async {
    final url = _baseUrl + "/${player.id}";

    try{
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'accept': 'application/json',
          'x-tournament-id': "${player.tournamentId}",
          'content-type': 'application/json'
        }
      );

      if(jsonDecode(response.body)['success']) {
        return int.parse(jsonDecode(response.body)['data']);
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Player> getPlayerById(int id, int tournamentId) async {
    final response = await http.get(
        Uri.parse(_baseUrl + "/$id"),
        headers: {
          "x-tournament-id":"$tournamentId",
          "accept" : "application/json"
        }
    );

    if(response.statusCode == 200) {
      var parsed = jsonDecode(response.body)['data'];

      return Player.fromJson(parsed);
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<List<List<Player>>> fetchBracketByTournamentId(int tournamentId) async {
    //first get all the players sorted by the amount of points they have
    List<Player> playersByPoints = await fetchPlayersList(tournamentId);

    List<Player> noTourIdPlayers = playersByPoints.where((player) =>
      player.tournamentId == null || player.tournamentId == ""
    ).take(32).toList();

    return getBracket(noTourIdPlayers);
  }

  getBracket(List<Player> players) {
    assert(players.length > 1, "Tournament needs at least 2 players");
    int rounds = (log(players.length) / log(2)).ceil();
    assert(players.length == pow(2, rounds).toInt(), "Current implementation requires exactly 2^n players");
    List<List<int>> matches = PlayersRepositoryHelper.getMatches(rounds);
    return injectPlayers(matches, players);
  }

  injectPlayers(List<List<int>> matches, List<Player> players) {
    return matches.map(
            (match) => [
              players[match[0] - 1],
              players[match[1] - 1]
            ]
    ).toList();
  }


  convertToPlayerModel(List responseData) {
    return List<Player>.from(responseData.map((i) => Player.fromJson(i)));
  }
}