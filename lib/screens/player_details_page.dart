import 'package:flutter/material.dart';
import '../screens/widgets/layout.dart';

class PlayerDetailsPage extends StatefulWidget {
  final int id;
  final int tournamentId;

  const PlayerDetailsPage({
    Key? key,
    required this.id,
    required this.tournamentId
  }) : super(key: key);

  @override
  State<PlayerDetailsPage> createState() => _PlayerDetailsPageState();
}

class _PlayerDetailsPageState extends State<PlayerDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Layout(
      body: Center(
        child: Text("HERE"),
      ),
    );
  }
}
