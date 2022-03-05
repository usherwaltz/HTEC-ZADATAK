import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../models/players_model.dart';

class TournamentDetailsRepository {
  final String _baseUrl = 'http://internships-mobile.htec.co.rs/api/players';

  static const emptyList = [];

  Future<List<Players>> fetchPlayersList(int tournamentId) async {
    final response = await http.get(Uri.parse(_baseUrl), headers: {"x-tournament-id":"$tournamentId"});

    if(response.statusCode == 200) {
      var parsed = jsonDecode(response.body)['data'];

      List<Players> players = convertToPlayerModel(parsed);
      players.sort((b, a) => a.points.compareTo(b.points));
      return players;
    } else {
      throw Exception("Failed to load data");
    }
  }

  convertToPlayerModel(List responseData) {
    return List<Players>.from(responseData.map((i) => Players.fromJson(i)));
  }
}