import 'package:flutter/material.dart';
import '../../../routes/routes.dart';
import '../../../services/navigation_service.dart';
import '../../../locator.dart';
import 'appbar_default.dart';

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
      IconButton(
        onPressed: () {
          locator<NavigationService>().navigateTo(Routes.brackets, []);
        },
        icon: const Icon(
          Icons.account_tree,
          color: Colors.white,
        )
      ),
    ],

  );
}