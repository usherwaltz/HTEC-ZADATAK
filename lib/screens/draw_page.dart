import 'package:flutter/material.dart';
import '../screens/widgets/app_bar/appbar_default.dart';
import '../screens/widgets/layout.dart';

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
