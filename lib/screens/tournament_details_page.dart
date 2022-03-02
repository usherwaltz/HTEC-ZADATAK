import 'package:flutter/material.dart';
import '../../helper_widgets/layout.dart';
import '../../helper_classes/page_appbars.dart';

class TournamentDetailsPage extends StatefulWidget {
  final int tournamentId;

  const TournamentDetailsPage({
    Key? key,
    required this.tournamentId
  }) : super(key: key);

  @override
  State<TournamentDetailsPage> createState() => _TournamentDetailsPageState();
}

class _TournamentDetailsPageState extends State<TournamentDetailsPage> {
  @override
  Widget build(BuildContext context) {
    var appbar = PageAppBars.tournamentDetailsPage;
    appbar.tournamentId = widget.tournamentId;
    return Layout(
      appBar: appbar,
      body: Container()
    );
  }
}
