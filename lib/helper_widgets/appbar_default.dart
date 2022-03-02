import 'dart:ui';

import 'package:flutter/material.dart';
import '../helper_classes/styles.dart';

class AppBarDefault extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final bool centerTitle;
  final List<Widget> actions;
  final String title;
  final titleStyle;

  AppBarDefault(
      { Key? key,
        this.centerTitle = false,
        this.actions = const [],
        this.title = '',
        this.titleStyle
      }) : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: titleStyle ?? Styles.appBarStyle,
      ),
      centerTitle: centerTitle,
      actions: actions,
      automaticallyImplyLeading: true,
    );
  }
}
