import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/core/styles.dart';
import 'package:object_note/utils/log_util.dart';
import 'package:object_note/utils/string_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static final Global _instance = Global._init();

  factory Global.init() => _instance;

  static late BuildContext context;
  static late SharedPreferences prefs;

  Global._init() {
    Log.d('AppConfig init()');
    SharedPreferences.getInstance().then((sharedPreferences) {
      prefs = sharedPreferences;
      //theme
      String theme = prefs.getString('theme') ?? 'system';
      setThemeMode(ThemeMode.values.firstWhere((e) => describeEnum(e) == theme,
          orElse: () => ThemeMode.system));
      //locale
      String locale = prefs.getString('locale') ?? 'system';
      setLocale(locale);
    });
  }

  static Future<void> setThemeMode(ThemeMode themeMode) async {
    Styles.themeMode.value = themeMode;
    Get.changeThemeMode(themeMode);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', describeEnum(themeMode));
  }

  static Future<void> setLocale(String localeString) async {
    Styles.locale.value = localeString;
    Get.updateLocale(
        StringUtils.stringToLocale(localeString, Get.deviceLocale));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', localeString);
  }
}
