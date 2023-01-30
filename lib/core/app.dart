import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../i18n/translations.dart';
import 'app_config.dart';
import 'app_controller.dart';

Widget createApp() {
  Get.put(AppController());
  return GetMaterialApp(
    title: 'Flutter Demo',
    initialRoute: RouteConfig.splashPage,
    getPages: RouteConfig.getPages,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ThemeConfig.lightColorScheme,
      fontFamily: AppConfig.fontFamily,
    ),
    darkTheme: ThemeData(
      useMaterial3: true,
      colorScheme: ThemeConfig.darkColorScheme,
      fontFamily: AppConfig.fontFamily,
    ),
    scrollBehavior: MyCustomScrollBehavior(),
    translations: TranslationStrings(),
    locale: Get.deviceLocale,
    fallbackLocale: const Locale('en', 'US'),
  );
}
