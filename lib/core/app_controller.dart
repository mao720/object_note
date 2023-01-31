import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/translations.dart';
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

    String language = prefs.getString('locale') ?? 'system';
    setLanguage(language);
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    AppConfig.themeMode(themeMode);
    Get.changeThemeMode(themeMode);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', describeEnum(themeMode));
  }

  Future<void> setLanguage(String localeString) async {
    AppConfig.locale(localeString);
    if (localeString == 'system') {
      var deviceLocale = Get.deviceLocale;
      if (deviceLocale != null) {
        Get.updateLocale(deviceLocale);
      }
    } else {
      Get.updateLocale(TranslationStrings.supportLocale.firstWhere(
          (locale) => locale.toString() == localeString,
          orElse: () => Get.deviceLocale ?? AppConfig.fallbackLocale));
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', localeString);
  }
}
