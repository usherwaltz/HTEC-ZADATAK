import 'package:flutter/material.dart';
import 'appbar_default.dart';

class Layout extends StatelessWidget {
  const Layout({
    Key? key,
    required this.body,
    this.appBar
  }) : super(key: key);

  final Widget body;
  final appBar;

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
    );
  }
}
