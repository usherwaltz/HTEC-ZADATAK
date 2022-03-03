import 'package:flutter/widgets.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic>? navigateTo(String routeName, args) {
    return navigatorKey.currentState?.pushNamed(routeName, arguments: args);
  }

  goBack() {
    return navigatorKey.currentState?.pop();
  }
}