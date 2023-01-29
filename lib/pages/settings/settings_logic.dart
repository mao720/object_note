import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app_controller.dart';
import 'settings_state.dart';

class SettingsLogic extends GetxController {
  final SettingsState state = SettingsState();
  final AppController appController = Get.find();

  onThemeChanged(ThemeMode? themeMode) {
    if (themeMode != null) {
      appController.setThemeMode(themeMode);
    }
  }

  void onLanguageChanged(String? language) {
    if (language != null) {
      appController.setLanguage(language);
    }
  }
}
