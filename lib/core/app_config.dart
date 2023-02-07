import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/core/styles.dart';
import 'package:object_note/l10n/translation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {
  Future<void> _init() async {
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
    Styles.themeMode(themeMode);
    Get.changeThemeMode(themeMode);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', describeEnum(themeMode));
  }

  Future<void> setLanguage(String localeString) async {
    Styles.locale(localeString);
    if (localeString == 'system') {
      var deviceLocale = Get.deviceLocale;
      if (deviceLocale != null) {
        Get.updateLocale(deviceLocale);
      }
    } else {
      Get.updateLocale(Translation.supportLocale.firstWhere(
          (locale) => locale.toString() == localeString,
          orElse: () => Get.deviceLocale ?? Styles.fallbackLocale));
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', localeString);
  }

  static AppConfig get to => _instance;
  static final AppConfig _instance = AppConfig._internal().._init();

  AppConfig._internal();
}
