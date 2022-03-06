import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import '../../../models/player.dart';

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

    List<Player> noTourIdPlayers = playersByPoints.where((player) {
      return player.tournamentId == null || player.tournamentId == "";
    }).take(32).toList();

    List<List<Player>> playerMatches = getBracket(noTourIdPlayers);
    return playerMatches;
  }

  getBracket(List<Player> players) {
    int playersCount = players.length;
    int rounds = (log(playersCount) / log(2)).ceil();

    if(playersCount < 2) {
      return [];
    }

    List<List<int>> matches = [[1, 2]];

    for (int round = 1; round < rounds; round ++) {
      List<List<int>> roundMatches = [];
      int sum = (pow(2, round + 1) + 1).toInt();
      for (var match in matches) {
        int home = match[0];
        int away = sum - match[0];
        List<int> pair = [home, away];
        roundMatches.add(pair);
        home = sum - match[1];
        away = match[1];
        pair = [home, away];
        roundMatches.add(pair);
        roundMatches = randomizeElementsOrderInTwoDimensionalArray(
          Random().nextInt(4) + 1,
          roundMatches);
      }
      matches = roundMatches;
    }

    return injectPlayers(matches, players);
  }

  randomizeElementsOrderInTwoDimensionalArray(int rand, List<List<int>> roundMatches) {
    switch(rand) {
      case 1:
        return swapElementsInTwoDimensionalArray(roundMatches, [0, 0], [1, 0]);

      case 2:
        return swapElementsInTwoDimensionalArray(roundMatches, [0, 1], [1, 1]);

      case 3:
        return swapElementsInTwoDimensionalArray(roundMatches, [0, 0], [1, 0]);

      case 4:
        return swapElementsInTwoDimensionalArray(roundMatches, [0, 1], [1, 1]);
    }
  }

  swapElementsInTwoDimensionalArray(List<List<int>> rounds, List<int> indexA, List<int> indexB) {
    var temp = rounds[indexA[0]][indexB[1]];
    rounds[indexA[0]][indexA[1]] = rounds[indexB[0]][indexB[1]];
    rounds[indexB[0]][indexB[1]] = temp;

    return rounds;
  }

  injectPlayers(List<List<int>> matches, List<Player> players) {
    List<List<Player>> playerMatches = [];
    for (int i = 0; i < matches.length; i++) {
      List<int> pair = matches[i];
      List<Player> playersPair = [];
      for (int player = 0; player < pair.length; player++) {
        int position = pair[player];
        playersPair.add(players[position - 1]);
      }
      playerMatches.add(playersPair);
    }
    return playerMatches;
  }

  convertToPlayerModel(List responseData) {
    return List<Player>.from(responseData.map((i) => Player.fromJson(i)));
  }
}