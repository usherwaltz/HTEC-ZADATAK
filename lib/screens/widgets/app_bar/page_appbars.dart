import 'appbar_default.dart';

class PageAppBars {

  static int tourId = 0;

  set tournamentId(int tournamentId) {
    tourId = tournamentId;
  }

  static final homePage = AppBarDefault(
    title: 'Tennis Tournament'
  );

  static final createPlayer = AppBarDefault(
    title: 'Create Player',
  );

  static final updatePlayer = AppBarDefault(
    title: 'Update Player',
  );
}