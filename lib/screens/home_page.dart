import 'package:flutter/material.dart';
import '../helper_widgets/appbar_default.dart';
import '../helper_widgets/layout.dart';
import '../screens/draw_page.dart';
import '../helper_classes/page_appbars.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      appBar: AppBars.homePage,
      body: Column(),
    );
  }
}
