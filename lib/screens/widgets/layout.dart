import 'package:flutter/material.dart';
import 'app_bar/appbar_default.dart';

class Layout extends StatelessWidget {
  final Widget body;
  final appBar;
  final fab;

  const Layout({
    Key? key,
    required this.body,
    this.appBar,
    this.fab
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar ?? AppBarDefault(),
      /** With safe area we assure we won't have problems regarding notches and
       * rounded corners on certain devices (iPhone X and above for example)
       * */
      body: SafeArea(
        child: body
      ),
      floatingActionButton: fab,
    );
  }
}
