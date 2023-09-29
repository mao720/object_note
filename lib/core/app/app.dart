import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:get/get.dart';
import 'package:object_note/core/app/app_route.dart';
import 'package:object_note/core/app/global.dart';
import 'package:object_note/core/styles/theme.dart';
import 'package:object_note/core/styles/translation.dart';
import 'package:object_note/core/utils/log_util.dart';
import 'package:object_note/widgets/toast.dart';

Widget createApp() {
  Global.init();
  return GetMaterialApp(
    title: 'Object Note',
    //Route
    initialRoute: AppRoute.homePage,
    getPages: AppRoute.getPages,
    //Theme
    theme: Themes.lightThemeData,
    darkTheme: Themes.darkThemeData,
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
    fallbackLocale: Themes.fallbackLocale,
    debugShowCheckedModeBanner: false,
    builder: (context, child) {
      Log.d('GetX builder called');
      Toast.init(context);
      return FlutterEasyLoading(child: child);
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
