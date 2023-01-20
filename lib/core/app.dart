import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../i18n/translations.dart';
import 'app_controller.dart';
import 'config.dart';

Widget createApp() {
  Get.put(AppController());
  return GetMaterialApp(
    title: 'Flutter Demo',
    initialRoute: RouteConfig.splashPage,
    getPages: RouteConfig.getPages,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ThemeConfig.lightColorScheme,
      fontFamily: ThemeConfig.fontFamily,
    ),
    darkTheme: ThemeData(
      useMaterial3: true,
      colorScheme: ThemeConfig.darkColorScheme,
      fontFamily: ThemeConfig.fontFamily,
    ),
    scrollBehavior: MyCustomScrollBehavior(),
    translations: TranslationStrings(),
    locale: Get.deviceLocale,
    fallbackLocale: const Locale('en', 'US'),
  );
}
