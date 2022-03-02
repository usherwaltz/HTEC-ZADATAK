import 'package:flutter/material.dart';
import '../services/navigation_service.dart';
import '../locator.dart';
import '../helper_widgets/appbar_default.dart';

class PageAppBars {

  static int tourId = 0;

  set tournamentId(int tournamentId) {
    tourId = tournamentId;
  }

  static final homePage = AppBarDefault(
    title: 'Tennis Tournament'
  );

  static final tournamentDetailsPage = AppBarDefault(
    actions: [
      TextButton(
        onPressed: () {
          locator<NavigationService>().navigateTo('/draw-page', []);
        },
        child: const Center(
          child: Text(
            "Draw",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20
            ),
          ),
        ),
      ),
    ],

  );
}