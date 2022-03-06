import 'dart:convert';
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

  convertToPlayerModel(List responseData) {
    return List<Player>.from(responseData.map((i) => Player.fromJson(i)));
  }
}