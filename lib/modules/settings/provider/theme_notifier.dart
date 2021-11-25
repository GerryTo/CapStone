import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:state_notifier/state_notifier.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system) {
    init();
  }
  static const themeModeKey = 'THEME_MODE';
  static const light = 'light';
  static const dark = 'dark';
  static const system = 'system';

  void set(ThemeMode themeMode) => state = themeMode;

  void saveThemePref(ThemeMode themeMode) async {
    String themeModeString;
    switch (themeMode) {
      case ThemeMode.dark:
        themeModeString = dark;
        break;
      case ThemeMode.light:
        themeModeString = light;
        break;
      case ThemeMode.system:
        themeModeString = system;
        break;
      default:
        themeModeString = system;
        break;
    }
    final sharedPref = await SharedPreferences.getInstance();
    final success = await sharedPref.setString(themeModeKey, themeModeString);
    if (success) set(themeMode);
  }

  void init() async {
    final sharedPref = await SharedPreferences.getInstance();
    final themeString = sharedPref.getString(themeModeKey);

    switch (themeString) {
      case 'light':
        set(ThemeMode.light);
        break;
      case 'dark':
        set(ThemeMode.dark);
        break;
      case 'system':
        set(ThemeMode.system);
        break;
      default:
        set(ThemeMode.system);
        break;
    }
  }
}
