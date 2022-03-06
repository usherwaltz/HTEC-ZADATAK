import 'dart:math';

class PlayersRepositoryHelper {
  static getMatches(int rounds) {
    assert(rounds >= 2, "Rounds value must be >= 2");
    List<List<int>> matches = [[1, 2]];

    for (int round = 1; round < rounds; round ++) {
      List<List<int>> roundMatches = [];
      int sum = (pow(2, round + 1) + 1).toInt();
      for (var match in matches) {
        int home = match[0];
        int away = sum - match[0];
        roundMatches.add([home, away]);

        home = sum - match[1];
        away = match[1];
        roundMatches.add([home, away]);
        randomizeElementsOrderInTwoDimensionalArray(
            Random().nextInt(4),
            roundMatches
        );
      }
      matches = roundMatches;
    }
    return matches;
  }

  static randomizeElementsOrderInTwoDimensionalArray(int rand, List<List<int>> roundMatches) {
    switch(rand) {
      case 1:
        swapElementsInTwoDimensionalArray(roundMatches, [0, 0], [1, 1]);
        break;

      case 2:
        swapElementsInTwoDimensionalArray(roundMatches, [0, 1], [1, 0]);
        break;

      case 3:
        swapElementsInTwoDimensionalArray(roundMatches, [0, 0], [1, 1]);
        swapElementsInTwoDimensionalArray(roundMatches, [0, 1], [1, 0]);
    }
  }

  static swapElementsInTwoDimensionalArray(List<List<int>> rounds, List<int> indexA, List<int> indexB) {
    var temp = rounds[indexA[0]][indexA[1]];
    rounds[indexA[0]][indexA[1]] = rounds[indexB[0]][indexB[1]];
    rounds[indexB[0]][indexB[1]] = temp;
  }
}