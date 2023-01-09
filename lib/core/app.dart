import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_controller.dart';
import 'config.dart';

Widget createApp() {
  Get.put(AppController());
  return GetMaterialApp(
    title: 'Flutter Demo',
    initialRoute: RouteGet.splashPage,
    getPages: RouteGet.getPages,
    theme: ThemeData(
      brightness: Brightness.light,
      fontFamily: AppConfig.fontFamily,
      primarySwatch: Colors.green,
    ),
    darkTheme: ThemeData(
      brightness: Brightness.dark,
      fontFamily: AppConfig.fontFamily,
    ),
    scrollBehavior: MyCustomScrollBehavior(),
  );
}
