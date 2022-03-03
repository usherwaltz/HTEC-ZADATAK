import 'package:flutter/material.dart';
import '../screens/widgets/layout.dart';

class CreatePlayerPage extends StatefulWidget {
  final int tournamentId;

  const CreatePlayerPage({
    Key? key,
    required this.tournamentId,
  }) : super(key: key);

  @override
  State<CreatePlayerPage> createState() => _CreatePlayerPageState();
}

class _CreatePlayerPageState extends State<CreatePlayerPage> {
  @override
  Widget build(BuildContext context) {
    return Layout(
      body: Center(
        child: Text("HERE ${widget.tournamentId}"),
      ),
    );
  }
}
