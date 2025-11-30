import 'package:flutter/material.dart';

class ThemeManager {
  static final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(ThemeMode.system);

  static void setThemeMode(ThemeMode mode) {
    themeModeNotifier.value = mode;
  }
}
