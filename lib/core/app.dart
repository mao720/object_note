import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:get/get.dart';
import 'package:object_note/core/app_config.dart';
import 'package:object_note/core/app_route.dart';
import 'package:object_note/core/styles.dart';
import 'package:object_note/l10n/translation.dart';
import 'package:object_note/utils/log_util.dart';
import 'package:object_note/utils/screen_adaption_util.dart';

Widget createApp() {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig.init();
  return GetMaterialApp(
    title: 'Flutter Demo',
    //Route
    initialRoute: AppRoute.homePage,
    getPages: AppRoute.getPages,
    //Theme
    theme: Styles.lightThemeData,
    darkTheme: Styles.darkThemeData,
    //ScrollBehavior
    scrollBehavior: MyCustomScrollBehavior(),
    //Locale
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      LocaleNamesLocalizationsDelegate()
    ],
    supportedLocales: Translation.supportLocale,
    translations: Translation(),
    fallbackLocale: Styles.fallbackLocale,
    builder: (context, child) {
      Log.d('GetMaterialApp builder');
      ScreenAdaptionUtil.init(context);
      return child ?? const SizedBox.shrink();
    },
  );
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
