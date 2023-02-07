import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/core/app_config.dart';
import 'package:object_note/pages/settings/settings_state.dart';

class SettingsLogic extends GetxController {
  final SettingsState state = SettingsState();

  onThemeChanged(ThemeMode themeMode) {
    AppConfig.to.setThemeMode(themeMode);
  }

  onLanguageChanged(String language) {
    AppConfig.to.setLanguage(language);
  }
}
