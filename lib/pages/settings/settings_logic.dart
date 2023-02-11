import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/core/global.dart';
import 'package:object_note/pages/settings/settings_state.dart';

class SettingsLogic extends GetxController {
  final SettingsState state = SettingsState();

  onThemeChanged(ThemeMode themeMode) {
    Global.setThemeMode(themeMode);
  }

  onLocaleChanged(String locale) {
    Global.setLocale(locale);
  }
}
