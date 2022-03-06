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
  TabBar? bottom;
  double? height;

  AppBarDefault(
      { Key? key,
        this.centerTitle = false,
        this.actions = const [],
        this.title = '',
        this.titleStyle,
        this.leading,
        this.tourId,
        this.bottom,
        this.height
      }) : preferredSize = Size.fromHeight(height ?? 50),
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
      bottom: bottom,
    );
  }
}
