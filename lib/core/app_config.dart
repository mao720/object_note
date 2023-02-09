import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/core/styles.dart';
import 'package:object_note/l10n/translation.dart';
import 'package:object_note/utils/log_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {
  static AppConfig? _instance;

  AppConfig._();

  factory AppConfig.init() {
    _instance ??= AppConfig._().._init();
    return _instance!;
  }

  _init() async {
    Log.d('AppConfig init()');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //theme
    String themeText = prefs.getString('theme') ?? 'system';
    ThemeMode themeMode;
    try {
      themeMode =
          ThemeMode.values.firstWhere((e) => describeEnum(e) == themeText);
    } catch (e) {
      themeMode = ThemeMode.system;
    }
    if (themeMode != Styles.themeMode.value) setThemeMode(themeMode);
    //locale
    String locale = prefs.getString('locale') ?? 'system';
    if (locale != Styles.locale.value) setLocale(locale);
  }

  static Future<void> setThemeMode(ThemeMode themeMode) async {
    Styles.themeMode(themeMode);
    Get.changeThemeMode(themeMode);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', describeEnum(themeMode));
  }

  static Future<void> setLocale(String localeString) async {
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
}
