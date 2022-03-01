import 'dart:html';

import 'package:flutter/material.dart';

class TournamentCard extends StatelessWidget {
  const TournamentCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: const [
          Text('Turnir 1'),
          Text('ID: 00001')
        ],
      ),
    );
  }
}
