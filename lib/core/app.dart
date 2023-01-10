import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_controller.dart';
import 'color_schemes.g.dart';
import 'config.dart';

Widget createApp() {
  Get.put(AppController());
  return GetMaterialApp(
    title: 'Flutter Demo',
    initialRoute: RouteGet.splashPage,
    getPages: RouteGet.getPages,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
      fontFamily: AppConfig.fontFamily,
    ),
    darkTheme: ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      fontFamily: AppConfig.fontFamily,
    ),
    scrollBehavior: MyCustomScrollBehavior(),
  );
}
