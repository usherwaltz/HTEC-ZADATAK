import 'package:flutter/material.dart';
import '../services/navigation_service.dart';
import '../locator.dart';
import '../helper_widgets/appbar_default.dart';

class AppBars {

  // final _navigationService = locator<NavigationService>();

  static final homePage = AppBarDefault(
    title: 'Turnir',
    actions: [
      TextButton(
        onPressed: () {
          locator<NavigationService>().navigateTo('/draw-page');
        },
        child: const Center(
          child: Text(
            "Žreb",
            style: TextStyle(
                color: Colors.white
            ),
          ),
        ),
      ),
    ],
  );
}