import 'package:flutter/material.dart';
import '../helper_widgets/appbar_default.dart';
import '../helper_widgets/layout.dart';

class DrawPage extends StatelessWidget {
  const DrawPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      appBar: AppBarDefault(
        title: 'Žreb',
      ),
      body: Column(),
    );
  }
}
