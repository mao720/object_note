import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/core/app/app_route.dart';
import 'package:object_note/core/styles/theme.dart';
import 'package:object_note/core/utils/constants.dart';
import 'package:object_note/core/utils/log_util.dart';
import 'package:object_note/core/utils/string_utils.dart';
import 'package:object_note/modal/user.dart';
import 'package:object_note/widgets/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static final Global _instance = Global._init();

  factory Global.init() => _instance;

  static late SharedPreferences prefs;
  static Rx<User> rxUser = Rx(User());

  Global._init() {
    WidgetsFlutterBinding.ensureInitialized();
    Log.d('AppConfig init()');
    SharedPreferences.getInstance().then((sharedPreferences) {
      prefs = sharedPreferences;
      //theme
      String theme = prefs.getString(Constants.theme) ?? 'system';
      setThemeMode(ThemeMode.values.firstWhere((e) => describeEnum(e) == theme,
          orElse: () => ThemeMode.system));
      //locale
      String locale = prefs.getString(Constants.locale) ?? 'system';
      setLocale(locale);
      //User
      String userJson = prefs.getString(Constants.user) ?? '';
      if (userJson.isNotEmpty) {
        rxUser.value = User.fromJson(jsonDecode(userJson));
      }
    });
  }

  static Future<void> setThemeMode(ThemeMode themeMode) async {
    Themes.rxThemeMode.value = themeMode;
    Get.changeThemeMode(themeMode);
    await prefs.setString(Constants.theme, describeEnum(themeMode));
  }

  static Future<void> setLocale(String localeString) async {
    Themes.rxLocale.value = localeString;
    Get.updateLocale(
        StringUtils.stringToLocale(localeString, Get.deviceLocale));
    await prefs.setString(Constants.locale, localeString);
  }

  static Future<void> setUser(User user) async {
    Global.rxUser.value = user;
    await prefs.setString(Constants.user, jsonEncode(user));
  }

  static Future<void> setAvatarUrl(String avatarUrl) async {
    Global.rxUser.update((user) {
      user?.avatar = avatarUrl;
    });
    await prefs.setString(Constants.user, jsonEncode(Global.rxUser.value));
  }

  static Future onLogout() async {
    await setUser(User());
    Toast.info('登录信息已过期，请重新登录'.tr);
    await Future.delayed(const Duration(milliseconds: 500));
    Get.toNamed(AppRoute.loginPage);
  }
}
