import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:turnir/screens/blocs/repository_helpers/players_repository/players_repository_helper.dart';

void main() {
  PlayersRepositoryHelper.getMatches(5);

  group("Tournament bracket testing. (seeds testing)", () {

    test("Exception expected when rounds are negative", () {
      expect(checkIfExceptionThrown(()=> PlayersRepositoryHelper.getMatches(-1)), true);
    });
    test("Exception expected when rounds are zero", () {
      expect(checkIfExceptionThrown(()=> PlayersRepositoryHelper.getMatches(0)), true);
    });
    test("Exception expected with one round", () {
      expect(checkIfExceptionThrown(()=> PlayersRepositoryHelper.getMatches(1)), true);
    });
    test("Players meet earlier than they should", () {
      var matches2d = PlayersRepositoryHelper.getMatches(5);
      var matches = twoDListToOneDList(matches2d);

      for( int round = 1; round <= 4; ++ round){
        int currentPlayers = pow(2, round).toInt();
        var segments = splitInSegments(matches, currentPlayers);
        var segmentsOfPlayers = List<int>.generate(currentPlayers, (i) => i + 1)
            .map((player) => segments.indexWhere((segment) => segment.contains(player)));
        expect(segmentsOfPlayers.toSet().length == segmentsOfPlayers.length, true);
      }
    });
  });
}

List<List<int>> splitInSegments(List<int> players, int segments){
  assert(players.length % segments == 0, "Players/segments is not an rounds number");
  int segmentLength = players.length ~/ segments;
  List<List<int>> results = [];
  for( int i = 0; i < segments; ++i){
    List<int> currentSegment = [];
    for( int j = 0; j < segmentLength; ++j){
      currentSegment.add(players[segmentLength * i + j]);
    }
    results.add(currentSegment);
  }
  return results;
}

List<int> twoDListToOneDList(List<List<int>> list){
  List<int> results = <int>[];
  for(List<int> sublist in list ){
    for(int elementInSublist in sublist) {
      results.add(elementInSublist);
    }
  }
  return results;
}

bool checkIfExceptionThrown(Function a){
  bool exceptionThrown = false;
  try{
    a();
  }
  catch (_) {
    exceptionThrown = true;
  }
  return exceptionThrown;
}