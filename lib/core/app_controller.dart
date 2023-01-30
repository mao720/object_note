import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_config.dart';

class AppController extends GetxController {
  @override
  Future<void> onReady() async {
    super.onReady();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String themeText = prefs.getString('theme') ?? 'system';
    ThemeMode themeMode;
    try {
      themeMode =
          ThemeMode.values.firstWhere((e) => describeEnum(e) == themeText);
    } catch (e) {
      themeMode = ThemeMode.system;
    }
    setThemeMode(themeMode);

    String language = prefs.getString('language') ?? 'system';
    setLanguage(language);
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    AppConfig.themeMode(themeMode);
    Get.changeThemeMode(themeMode);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', describeEnum(themeMode));
  }

  Future<void> setLanguage(String language) async {
    AppConfig.language(language);
    if (language == 'system') {
      var deviceLocale = Get.deviceLocale;
      if (deviceLocale != null) {
        Get.updateLocale(deviceLocale);
      }
    } else {
      Get.updateLocale(Locale(language));
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
  }
}
