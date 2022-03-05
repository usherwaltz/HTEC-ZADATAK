import 'package:flutter/material.dart';

class AppBarDefault extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final bool centerTitle;
  final List<Widget> actions;
  String title;
  final titleStyle;
  final leading;
  var tourId;
  int screen = 0;

  static const int tournamentDetails = 1;
  static const int createPlayer = 2;

  AppBarDefault(
      { Key? key,
        this.centerTitle = false,
        this.actions = const [],
        this.title = '',
        this.titleStyle,
        this.leading,
        this.tourId
      }) : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  set tournamentDetailsId(int tournamentId) {
    tourId = tournamentId;
    screen = tournamentDetails;
  }

  @override
  Widget build(BuildContext context) {

    switch(screen) {
      case tournamentDetails:
        title = "Tournament ID: $tourId";
    }

    return AppBar(
      title: Text(
        title
      ),
      leading: leading,
      centerTitle: centerTitle,
      actions: actions,
      automaticallyImplyLeading: true,
    );
  }
}
