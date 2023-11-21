import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Themes {
  Themes._();

  static const fontFamily = 'LXGWWenKaiLite';
  static final rxThemeMode = ThemeMode.system.obs;
  static final rxLocale = Rx<String?>(null);
  static const fallbackLocale = Locale('en');

  static final lightThemeData = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.green,
    brightness: Brightness.light,
    fontFamily: Themes.fontFamily,
    visualDensity: VisualDensity.standard,
  );

  static final darkThemeData = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.green,
    brightness: Brightness.dark,
    fontFamily: Themes.fontFamily,
    visualDensity: VisualDensity.standard,
  );
}
