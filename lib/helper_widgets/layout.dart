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
      body: body,
    );
  }
}
