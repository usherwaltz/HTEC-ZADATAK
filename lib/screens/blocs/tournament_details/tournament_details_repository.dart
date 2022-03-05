import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../models/player.dart';

class TournamentDetailsRepository {
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

  Future<bool> createPlayer(Player player) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'accept': 'application/json',
        'x-tournament-id': "10001",
        'content-type': 'application/json'
      },
      body: jsonEncode(player),
    );

    // return the success value, maybe better to check the status code since
    // we never know if there will be a server side failure, I left it like this
    // for now
    return jsonDecode(response.body)['success'];
  }

  convertToPlayerModel(List responseData) {
    return List<Player>.from(responseData.map((i) => Player.fromJson(i)));
  }
}