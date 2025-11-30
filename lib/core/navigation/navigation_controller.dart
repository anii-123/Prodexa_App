import 'package:flutter/material.dart';

/// Navigation controller for MainNavigationPage
class NavigationController {
  static final ValueNotifier<int> pageIndexNotifier = ValueNotifier<int>(0);

  static void navigateToPage(int index) {
    pageIndexNotifier.value = index;
  }

  static void navigateToTasks() => navigateToPage(0);
  static void navigateToChecklists() => navigateToPage(1);
  static void navigateToProfile() => navigateToPage(2);
  static void navigateToSettings() => navigateToPage(3);
}
