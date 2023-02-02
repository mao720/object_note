import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:get/get.dart';

import '../l10n/translations.dart';
import 'app_config.dart';
import 'app_controller.dart';

Widget createApp() {
  Get.put(AppController());
  return GetMaterialApp(
    title: 'Flutter Demo',
    initialRoute: RouteConfig.homePage,
    getPages: RouteConfig.getPages,
    theme: ThemeData(
      useMaterial3: true,
      platform: TargetPlatform.iOS,
      colorScheme: ThemeConfig.lightColorScheme,
      fontFamily: AppConfig.fontFamily,
    ),
    darkTheme: ThemeData(
      useMaterial3: true,
      platform: TargetPlatform.iOS,
      colorScheme: ThemeConfig.darkColorScheme,
      fontFamily: AppConfig.fontFamily,
    ),
    scrollBehavior: MyCustomScrollBehavior(),
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      LocaleNamesLocalizationsDelegate()
    ],
    supportedLocales: TranslationStrings.supportLocale,
    translations: TranslationStrings(),
    locale: Get.deviceLocale,
    fallbackLocale: AppConfig.fallbackLocale,
  );
}
