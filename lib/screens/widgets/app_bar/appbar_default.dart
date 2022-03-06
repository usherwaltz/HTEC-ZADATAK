import 'package:flutter/material.dart';

class AppBarDefault extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final bool centerTitle;
  final List<Widget> actions;
  String title;
  final titleStyle;
  final leading;
  var tourId;

  AppBarDefault(
      { Key? key,
        this.centerTitle = false,
        this.actions = const [],
        this.title = '',
        this.titleStyle,
        this.leading,
        this.tourId
      }) : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {

    return AppBar(
      title: Text(
        title
      ),
      leading: leading,
      centerTitle: centerTitle,
      actions: actions,
      automaticallyImplyLeading: true,
    );
  }
}
